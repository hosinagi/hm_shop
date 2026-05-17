// 封装一个api 目的是返回业务侧要的数据结构
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/viewmodels/home.dart';
import 'package:hm_shop/utils/DioRequest.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  final tt = (await dioRequest.get(HttpContants.BANNER_LIST) as List).map((
    item,
  ) {
    return BannerItem.fromJSON(item as Map<String, dynamic>);
  }).toList();
  return tt;
}

// 封装一个api 目的是返回业务侧要的数据结构
Future<List<CategoryItem>> getCategoryListAPI() async {
  final tt = (await dioRequest.get(HttpContants.CATEGORY_LIST) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
  return tt;
}

// 优惠推荐 - 结果
Future<SpecialRecommendResult> getSpecialRecommendListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpContants.PRODUCT_LIST),
  );
}

// 热榜推荐 - 结果
Future<SpecialRecommendResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpContants.IN_VOGUE_LIST),
  );
}

// 一战式买全 - 结果
Future<SpecialRecommendResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpContants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpContants.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}