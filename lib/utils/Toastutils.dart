import 'package:flutter/material.dart';

class Toastutils {
  // 阀门控制
  static bool showLoading = false;
  static void showToast(BuildContext context, String? msg) {
    if(Toastutils.showLoading == true) {
      return;
    }
    Toastutils.showLoading = true;
    // 由于提示三秒后消失，所以要创建异步微任务，延后改值
    Future.delayed(Duration(seconds: 3), () {
      Toastutils.showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        // 设置圆角
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        // 解除底部固定状态
        behavior: SnackBarBehavior.floating,
        // 设置短信出现时长
        duration: Duration(seconds: 3),
        content: Text(msg ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
