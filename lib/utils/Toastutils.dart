import 'package:flutter/material.dart';

class Toastutils {
  static void showToast(BuildContext context, String? msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 120,
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
