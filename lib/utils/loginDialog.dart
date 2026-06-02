import 'package:flutter/material.dart';

class LoginDialog {
  // 展示弹窗
  static void show(BuildContext context, {String message = "加载中..."}) {
    showDialog(context: context, builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // 设置弹窗背景为透明
        child: Center(
          // 这里的container其实就是弹窗内容的载体
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 组件包裹延申到最小
              children: [
                // 转圈动画组件,可以调整样式但是这里设置默认
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text(message)
              ],
            ),
          ),
        ),
      );
    });
  }
  // 关闭弹窗
  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}