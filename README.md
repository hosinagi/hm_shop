# hm_shop

hm_shop 是一个基于 Flutter 的电商 App 学习项目，界面参考“惠多美商城”设计。项目使用公开教程接口作为数据源，重点练习 Flutter 页面组织、网络请求封装、Token 持久化、状态管理和无限滚动等移动端常见能力。

## 项目解决什么问题

本项目用于练习和展示一个电商 App 的常见客户端功能，包括：

- 从服务端获取并展示首页商品数据
- 处理登录状态和用户信息
- 管理登录 Token 的持久化
- 实现下拉刷新和滚动分页加载
- 组织 `api`、`viewmodels`、`widgets`、`stores` 等前端模块

当前项目主要是学习型实现，不是可直接上线的完整电商系统。

## 主要功能

### 已实现的功能

- 首页
  - 轮播图
  - 商品分类
  - 特惠推荐
  - 爆款推荐
  - 一站买全
  - 推荐商品网格
  - 下拉刷新
  - 滚动到底部自动加载更多
- 登录
  - 手机号格式校验
  - 密码长度和字符校验
  - 用户协议勾选校验
  - 调用登录接口
  - 登录成功后保存 Token
  - 登录失败提示错误信息
- 我的
  - 展示当前登录用户头像和用户 ID
  - 未登录时跳转登录页
  - 登录后可以退出登录
  - 猜你喜欢商品分页加载

### 当前仅提供界面占位

以下模块目前只有基础 UI，业务逻辑尚未完成：

- 分类页
- 购物车页
- 会员开通按钮
- 我的收藏、我的足迹、我的客服入口
- 我的订单及订单状态入口

## 技术栈

- Flutter
- Dart
- Dio
- GetX
- shared_preferences
- carousel_slider

## 数据源

项目默认请求以下公开接口地址：

```text
https://meikou-api.itheima.net
```

主要接口：

```text
POST /login
GET  /home/banner
GET  /home/category/head
GET  /hot/preference
GET  /hot/inVogue
GET  /hot/oneStop
GET  /home/recommend
GET  /home/goods/guessLike
GET  /member/profile
```

因此运行项目前需要保证设备可以访问网络。

## 安装方法

### 环境要求

安装 Flutter SDK，并确保 `flutter doctor` 能正常识别目标平台。

当前 `pubspec.yaml` 使用较新的 Dart SDK 约束，建议先运行：

```bash
flutter --version
dart --version
```

### 安装依赖

进入项目目录后运行：

```bash
flutter pub get
```

### 运行项目

连接真机或启动模拟器后运行：

```bash
flutter run
```

如果要在 Chrome 中运行：

```bash
flutter run -d chrome
```

## 使用方法

1. 启动 App 后默认进入首页。
2. 在首页可以查看轮播图、分类、推荐和商品网格。
3. 首页下拉可以刷新数据。
4. 首页滚动到底部会自动加载更多商品。
5. 点击底部“我的”进入个人中心。
6. 点击“立即登录”进入登录页。
7. 输入账号和密码，勾选用户协议后点击登录。
8. 登录成功后，个人中心会显示用户信息。
9. 点击个人中心右上角“退出”可以清除登录状态。

## 输入输出示例

### 登录

登录页请求参数结构示例：

```json
{
  "account": "13800138000",
  "password": "abc123"
}
```

登录成功后，应用会得到用户信息并保存 Token。响应结构示例：

```json
{
  "account": "13800138000",
  "avatar": "https://example.com/avatar.png",
  "birthday": "",
  "cityCode": "",
  "gender": "",
  "id": "user-id",
  "mobile": "13800138000",
  "nickname": "示例用户",
  "profession": "",
  "provinceCode": "",
  "token": "example-token"
}
```

应用表现：

```text
输入：合法手机号和密码，并勾选用户协议
输出：提示“登录成功”，返回个人中心并显示用户信息

输入：手机号格式错误
输出：显示“手机号格式不正确”

输入：未勾选用户协议
输出：显示“请勾选用户协议”
```

### 首页推荐商品

`/home/recommend` 接口按 `limit` 返回商品列表，首页滚动到底部时继续请求。成功后商品网格追加新数据；请求失败时显示错误提示，并恢复加载状态。

### 猜你喜欢

`/home/goods/guessLike` 使用分页参数：

```json
{
  "page": 1,
  "pageSize": 10
}
```

当当前页达到接口返回的总页数时停止继续加载。

## 项目结构

```text
lib/
  api/          接口请求
  constants/    全局常量和接口地址
  pages/        页面
  routes/       路由
  stores/       Token 和用户状态
  utils/        网络、提示和弹窗工具
  viewmodels/   数据模型
  widgets/      页面组件
```

## 当前限制

- 数据接口来自公开教程服务，可能受网络或服务可用性影响。
- 分类页和购物车页尚未实现完整业务。
- 订单、收藏、足迹、客服等入口目前只是 UI 展示。
- 尚未覆盖完整的商品详情、下单、支付和订单流程。
