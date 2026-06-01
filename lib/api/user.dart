import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';


// 定义登录API
Future<UserInfo> loginAPI(Map<String, dynamic> params) async{
  return UserInfo.fromJSON(
    await dioRequest.post(HttpContants.LOGIN, data: params),
  );
}

// 用户信息API
Future<UserInfo> getuserinfoAPI() async{
  return UserInfo.fromJSON(
    // 这里就调用了dioRequest的步骤，用Authorazation Bearer的方法获取了token
    // 下一步就是向服务器拿到token对应的用户信息共享到Getx中
    await dioRequest.get(HttpContants.USER_PROFILE)
  );
}
