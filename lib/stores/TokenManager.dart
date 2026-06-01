import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 初始化token
  // 利用shared_preferences插件提供的方法，返回持久化对象的实例对象
  // 这个实例中会有对应的操作方法，但是核心在于这个getInstance，使用它就可以调用磁盘进行写入或获取
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }
  
  // 定义私有变量为空
  String _token = '';
  // 在初始化中获取token
  init() async{
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalContants.TOKEN_KEY) ?? "";
  }
  // 设置token
  Future<void> setToken(String val) async{
    // 获取持久化实例,val就是token
    final prefs = await _getInstance();
    // 通过setString方法就可以将token写入持久化也就是磁盘上
    prefs.setString(GlobalContants.TOKEN_KEY, val);
    _token = val;
  }
  // 获取token
  String getToken() {
    return _token;
  }
  // 删除token
  Future<void> removeToken() async{
    final prefs = await _getInstance();
    prefs.remove(GlobalContants.TOKEN_KEY); // 删除磁盘上的数据
    _token = ""; // 磁盘删了，内存同步更新
  }
}
// 创建单例，用于外界获取
final tokenManager = TokenManager();