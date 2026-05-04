import 'package:flutter/material.dart';
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
  //函数封装CustomScrollView内容
  List<Widget> _getScrollchildren() {
    return [
      //包裹普通Widget的sliver家族
      SliverToBoxAdapter(child: HmSlider()), //轮播图
      //需要间隔放SizeBox
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //SliverGridView和SliverListView都只能纵向滚动，不能横向
      SliverToBoxAdapter(child: HmCategory()), //分类
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(child: HmSuggestion()), //推荐
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //爆款推荐和热门推荐均分空间
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: HmHot()),
              SizedBox(width: 10),
              Expanded(child: HmHot()),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //无限滚动利用SliverGridView就可以实现
      HmMoreList()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollchildren()); //只允许Sliver家族内容
  }
}
