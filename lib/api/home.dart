// 封装一个api 目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/viewmodels/home.dart';
import 'package:hm_shop/utils/DioRequest.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final result = await dioRequest.get(HttpContants.BANNER_LIST);
  print("🔥 轮播图原始数据：$result"); // 看控制台！
  final tt = (await dioRequest.get(HttpContants.BANNER_LIST) as List).map((
    item,
  ) {
    print("🔥 单条数据：$item");
    return BannerItem.fromJSON(item as Map<String, dynamic>);
  }).toList();
  return tt;
}
