import 'package:flutter/material.dart';
import 'package:hm_shop/routes/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';

Future<void> main() async {
  //在mian里runApp启动应用
  //但并不在main里构建MaterialApp,在routes里去构建并配置路由
  WidgetsFlutterBinding.ensureInitialized();
  // 启动前先把 token 从磁盘读出来，避免首页请求先于 token 初始化
  await tokenManager.init();
  // 在这里初始化token，init方法里有读取token的步骤
  // 所以直接在这里获取一下，避免后续首页ui构建与token获取时机的前后问题
  runApp(getRouteWidget());
}
