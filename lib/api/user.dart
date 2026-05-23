import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';


// 定义登录API
Future<UserInfo> loginAPI(Map<String, dynamic> params) async{
  return UserInfo.fromJSON(
    await dioRequest.post(HttpContants.LOGIN, data: params),
  );
}
