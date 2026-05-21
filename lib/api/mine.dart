import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';
// 封装猜你喜欢的API
// 猜你喜欢有参数page: 1, pageSize: 10,接口自带的
Future<GoodsDetailsItems> getGuessListAPI(Map<String, dynamic> params) async{
  return GoodsDetailsItems.formJSON(await dioRequest.get(HttpContants.GUESS_LIST, params: params));
}
