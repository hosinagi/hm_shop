import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> BannerList;
  HmSlider({Key? key, required this.BannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _controller = CarouselSliderController(); //控制轮播图跳转的控制器
  int _currentIndex = 0; //表示当前激活的导航灯

  //轮播图组件封装到函数中
  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screemWidth = MediaQuery.of(
      context,
    ).size.width; //这个context是这个Media Query自带的
    //轮播图插件CarouselSlider
    return CarouselSlider(
      carouselController: _controller, //绑定控制器
      items: List.generate(widget.BannerList.length, (int index) {
        return Image.network(
          widget.BannerList[index].imgUrl,
          fit: BoxFit.cover, //设置图片全覆盖
          width: screemWidth, //设置图片宽度
        );
      }), //返回List<widget>,长度和轮播图使用的Image
      options: CarouselOptions(
        viewportFraction: 1, //设置视口占比为1，即100%
        autoPlay: true, //设置为自动滚动，默认值3秒一次
        height: MediaQuery.of(context).size.width * (3 / 5), //可以设置图片高度,宽高比例5:3
        autoPlayInterval: Duration(seconds: 3), //更改自动滚动的时间间隔
        //一个轮播图切换就触发的回调函数
        onPageChanged: (int index, reason) {
          _currentIndex = index;//使_currentIndex与当前页面绑定
          setState(() {});//ui更新
        }
      ),
    );
  }

  //搜索栏的ui实现，目前暂不实现功能
  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          width: double.infinity,
          height: 50,
          child: Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  //返回底部指示灯导航部件
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, //主轴居中
          //有几个轮播图图片就循环几次
          children: List.generate(widget.BannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                //跳转，index是导航灯的index，因为已经绑定了页面，所以使用方法使页面跳转到点击触发的index
                _controller.animateToPage(index, duration: Duration(milliseconds: 300));
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),//设置动画效果过程为300毫秒
                height: 6,
                //在这边进行一个判断，如果导航灯的index==页面的index长度为40，否则为20
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  //在这边也进行一个判断如果导航灯的index==页面的index则为红色，否则为白色
                  color: index == _currentIndex ? Colors.white : Colors.blueGrey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Stack  -> 轮播图 -> 搜索框  -> 指示灯导航
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
