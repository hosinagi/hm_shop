import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/utils/Toastutils.dart';
import 'package:hm_shop/viewmodels/home.dart';
import 'package:hm_shop/widgets/Home/HmCategory.dart';
import 'package:hm_shop/widgets/Home/HmHot.dart';
import 'package:hm_shop/widgets/Home/HmMoreList.dart';
import 'package:hm_shop/widgets/Home/HmSlider.dart';
import 'package:hm_shop/widgets/Home/HmSuggestion.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //优惠推荐数据列表
  SpecialRecommendResult _SpecialRecommendList = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  //分类数据列表
  List<CategoryItem> _CategoryList = [];
  //函数列表封装轮播图图片数据列表
  List<BannerItem> _BannerList = [
    // BannerItem(id: "1", imaUrl: "https://img95.699pic.com/photo/60030/5424.jpg_wh860.jpg"),
    // BannerItem(id: "2", imaUrl: "https://img95.699pic.com/photo/50120/1209.jpg_wh860.jpg"),
    // BannerItem(id: "3", imaUrl: "https://img95.699pic.com/photo/50478/8568.jpg_wh860.jpg")
  ];
  //热榜推荐数据列表
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  //一战式买全数据列表
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  //推荐列表数据列表
  List<GoodDetailItem> _recommendList = [];

  //函数封装CustomScrollView内容
  List<Widget> _getScrollchildren() {
    return [
      //包裹普通Widget的sliver家族
      SliverToBoxAdapter(child: HmSlider(BannerList: _BannerList)), //轮播图
      //需要间隔放SizeBox
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //SliverGridView和SliverListView都只能纵向滚动，不能横向
      SliverToBoxAdapter(child: HmCategory(categoryList: _CategoryList)), //分类
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: HmSuggestion(SpecialRecommendList: _SpecialRecommendList),
      ), //推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //爆款推荐和热门推荐均分空间
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //无限滚动利用SliverGridView就可以实现
      HmMoreList(recommendList: _recommendList),
    ];
  }

  //初始化状态
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getBannerList();
    // _getCategoryList();
    // _getSpecialRecommendList();
    // _getInVogueList();
    // _getOneStopList();
    // _getRecommendList();
    _registerEvent();
    Future.microtask(() {
      // 使用key操纵函数
      _key.currentState?.show();
    });
  }
  // 由于initState -> build -> 下拉刷新组件 -> 才可以操作它
  // 所以不能直接使用，因为在build阶段这个函数还未构建完成执行没有结果
  // 需要使用Future.micoTask微任务使其异步完成

  //获取分类数据
  Future<void> _getCategoryList() async {
    _CategoryList = await getCategoryListAPI();
    setState(() {});
  }

  //获取轮播图数据
  Future<void> _getBannerList() async {
    _BannerList = await getBannerListAPI();
    setState(() {});
  }

  //获取优惠推荐数据
  Future<void> _getSpecialRecommendList() async {
    _SpecialRecommendList = await getSpecialRecommendListAPI();
    setState(() {});
  }

  //获取热榜推荐数据
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  //获取一战式买全数据
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  //获取推荐列表数据
  int _page = 1;
  bool _isLoading = false; // 当前请求状态
  bool _hasMore = true; // 是否还有下一页

  Future<void> _getRecommendList() async {
    // 当正在请求状态或者没有下一页时，放弃请求
    if (_isLoading == true || _hasMore == false) {
      return;
    }
    _isLoading = true; // 占住位置，表示请求进行中
    int requestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false; // 松开位置，表示请求结束
    setState(() {});
    // 要10条请求给10条就进行下一次请求
    // 当要10条给不满10条则表示，数据已用光
    if (_recommendList.length > requestLimit) {
      _hasMore = false;
      return;
    }
    _page++; // 请求完成页码加一
  }

  // 监听滚动到底部的事件
  void _registerEvent() {
    // 这个addListener方法，当用户进行滚动行为时就会触发逻辑
    _controller.addListener(() {
      // 这个pixels指已滚动距离
      // 这个maxScrollExtent指滚动最大距离
      // 只要已滚动距离>最大滚动距离-50，则表示到底了可以请求了
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        // 在这里执行加载下一页数据请求
        _getRecommendList();
      }
    });
  }

  final ScrollController _controller = ScrollController(); // 划动监听控制器

  // 封装onRefresh函数，实现下拉重置数据
  Future<void> _onRefresh() async {
    // 参数回归
    _page = 1;
    bool _isLoading = false;
    bool _hasMore = true;
    // 重新获取数据
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    // 数据获取成功，显示提示消息
    Toastutils.showToast(context, "刷新成功");
  }

  // Globalkey是一个方法可以创建一个key绑定到Widget部件上，可以操作widget部件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    // 用RefreshIndicator包裹子组件，使其可以下拉
    return RefreshIndicator(
      key: _key, // 绑定key
      // 这个onRefresh需要返回一个异步函数
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _controller, // 给无限滚动绑定控制器
        slivers: _getScrollchildren(),
      ),
    );
    //只允许Sliver家族内容
  }
}
