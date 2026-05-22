import 'package:flutter/material.dart';
import 'package:hm_shop/utils/ToastUtils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phonController = TextEditingController(); // 账号控制器
  TextEditingController _codeController = TextEditingController(); // 密码控制器
  // 用户账号Widget
  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        // 判断不能为空
        if(value == null || value.isEmpty) {
          return "手机号不能为空";
        }
        // 判断手机号格式
        if(RegExp(r"^1[3-9]\d{8}").hasMatch(value) == false){
          return "手机号格式不正确";
        }
        return null;
      },
      controller: _phonController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      validator: (value) {
        if(value == null || value.isEmpty) {
          return "密码不能为空";
        }
        // 密码校验，6-16的数字 字母 下划线组合
        if(RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value) == false){
          return "请输入6到16位的数字字母或下划线";
        }
        return null;
      },
      controller: _codeController,
      // 是否隐藏输入值
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if(_key.currentState!.validate() == true) {
            // 进行勾选框的判断
            if(_isChecked == true) {
              // 校验通过
            }else{
              // 提示勾选用户协议
              Toastutils.showToast(context, "请勾选用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // 勾选Widget
  bool _isChecked = false;
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked, // 当前是否被勾选
          activeColor: Colors.black, // 勾选时的背景色
          checkColor: Colors.white, // 勾选时的对勾颜色
          onChanged: (bool? value) {
            _isChecked = value ?? false; // 空判断，为空则直接赋false
            setState(() {});
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        // 富文本设置样式
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // 创建globalkey控制From组件
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Form(
          key: _key,
          child: Container(
            padding: EdgeInsets.all(30),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildHeader(), // 头部Widegt
                SizedBox(height: 30),
                _buildPhoneTextField(),// 账号Widget
                SizedBox(height: 20), 
                _buildCodeTextField(),// 密码Widget
                SizedBox(height: 20), 
                _buildLoginButton(), // 登录按钮Widget
                SizedBox(height: 20),
                _buildCheckbox(), // 协议勾选Widget
              ],
            ),
          ),
        ),
      ),
    );
  }
}
