import 'package:get/state_manager.dart';
import 'package:hm_shop/viewmodels/user.dart';

// 需要共享的对象 需要一些共享的属性 属性需要响应式更新
class Usercontroller extends GetxController{
  var user = UserInfo.fromJSON({}).obs; // user对象监听了
  // 因为被obs包裹，所以想要取值的话得用user.value的形式才能取值或赋值
  updateUserInfo(UserInfo newUser) {
    user.value = newUser; // 用户操作后更新user对象。
  }
}