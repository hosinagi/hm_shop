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
  //分别将需要的轮播图组件封装到函数中
  Widget _getSlider() {
    // 在Flutter中获取屏幕宽度的方法
    final double screemWidth = MediaQuery.of(context).size.width;//这个context是这个Media Query自带的
    //返回轮播图插件
    return CarouselSlider(
      items: List.generate(widget.BannerList.length, (int index) {
        return Image.network(widget.BannerList[index].imaUrl,
        fit: BoxFit.cover,//设置图片全覆盖
        width: screemWidth,//设置图片宽度
      );
      }),  //返回List<widget>,长度和轮播图使用的Image
      options: CarouselOptions(
        viewportFraction: 1,//设置视口占比为1，即100%
        autoPlay: true, //设置为自动滚动，默认值3秒一次
        height: 300,// 可以设置图片高度
        autoPlayInterval: Duration(seconds: 3),//更改自动滚动的时间间隔
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Stack  -> 轮播图 -> 搜索框  -> 指示灯导航
    return Stack(children: [_getSlider()]);
  }
}
