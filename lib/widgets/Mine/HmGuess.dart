import 'package:flutter/material.dart';

// 封装猜你喜欢的封顶吸附的方法类
class HmGuess extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("猜你喜欢", style: TextStyle(fontSize: 20)),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 60; // 最大高度为60

  @override
  // TODO: implement minExtent
  double get minExtent => 60; // 最小高度为60，固定

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
  
}