import 'package:flutter/material.dart';

class BannerItem {
  String id;
  String imgUrl;
  //构造一个构造函数的语法糖，用于存储id与图片地址
  BannerItem({required this.id, required this.imgUrl });
  // 扩展一个工厂函数，一般factory来声明，转化数据类型,用于创建实例对象
  factory BannerItem.fromJSON(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");//进行一个空判断，防错
  }
  
}

// 从接口那拿到的数据，要转化成BannerItem能用的数据就必须转化
// Flutter中没有隐式转化，只能强制转化

//  {
//             "id": "1181622001",
//             "name": "气质女装",
//             "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c1/qznz.png",
//             "children": [
//                 {
//                     "id": "1191110001",
//                     "name": "半裙",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bq.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110002",
//                     "name": "衬衫",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_cs.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110022",
//                     "name": "T恤",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_tx.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110023",
//                     "name": "针织衫",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_zzs.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110024",
//                     "name": "夹克",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_jk.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110025",
//                     "name": "卫衣",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_wy.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 },
//                 {
//                     "id": "1191110028",
//                     "name": "背心",
//                     "picture": "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meikou/c2/qznz_bx.png?quality=95&imageView",
//                     "children": null,
//                     "goods": null
//                 }
//             ],
//             "goods": null
//         }

//根据json数据，编写class对象和工厂函数
// 分类对象
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    // 必须返回一个CategoryItem对象
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List)
                .map(
                  (item) => CategoryItem.formJSON(item as Map<String, dynamic>),
                )
                .toList()
    );
  }
}
