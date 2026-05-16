import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
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

      SliverToBoxAdapter(child: HmSuggestion(SpecialRecommendList: _SpecialRecommendList)), //推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //爆款推荐和热门推荐均分空间
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot(result: _inVogueResult, type: "hot")),
              SizedBox(width: 10),
              Expanded(child: HmHot(result: _oneStopResult, type: "step")),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //无限滚动利用SliverGridView就可以实现
      HmMoreList()
    ];
  }
  
  //初始化状态
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getSpecialRecommendList();
    _getInVogueList();
    _getOneStopList();
  }
  //获取分类数据
  void _getCategoryList() async {
    _CategoryList = await getCategoryListAPI();
    setState(() {});
  }
  //获取轮播图数据
  void _getBannerList() async {
    _BannerList = await getBannerListAPI();
    setState(() {});
  }
  //获取优惠推荐数据
  void _getSpecialRecommendList() async {
    _SpecialRecommendList = await getSpecialRecommendListAPI();
    setState(() {});
  }
  //获取热榜推荐数据
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }
  //获取一战式买全数据
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollchildren()); //只允许Sliver家族内容
  }
}
