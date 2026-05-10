import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  //分类数据列表
  final List<CategoryItem> categoryList;
  HmCategory({Key? key, required this.categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    //return ListView.builder
    //只用ListView是不行的，因为ListView不能设置高度，会导致显示不出来
    //得用SizeBox或Container去包裹
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 209, 215, 220),
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(widget.categoryList[index].picture, width: 40, height: 40),
                Text(widget.categoryList[index].name, style:TextStyle(color:Colors.black)),
              ],
            ),
          );
        }
      ),
    );
  }
}