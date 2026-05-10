import 'package:flutter/material.dart';

class BannerItem {
  String id;
  String imgUrl;
  //构造一个构造函数的语法糖，用于存储id与图片地址
  BannerItem({required this.id, required this.imgUrl });
  // 扩展一个工厂函数，一般factory来声明，转化数据类型,用于船舰实例对象
  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");//进行一个空判断，防错
  }
  
}

// 从接口那拿到的数据，要转化成BannerItem能用的数据就必须转化
// Flutter中没有隐式转化，只能强制转化