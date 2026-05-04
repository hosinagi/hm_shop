import 'package:flutter/material.dart';

class HmCategory extends StatefulWidget {
  HmCategory({Key? key}) : super(key: key);

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
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //height: 60,
            width: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text("分类${index + 1}", style:TextStyle(color:Colors.white, fontSize: 10)),
          );
        }
      ),
    );
  }
}