//此处定义常量，需要就从此处调用
// 全局的常量
class GlobalContants {
  static const String BASE_URL = "https://meikou-api.itheima.net"; // 基础地址
  static const Duration TIME_OUT = Duration(seconds: 10); // 超时时间
  static const String SUCCESS_CODE = "1"; // 业务状态/成功状态
  static const String TOKEN_KEY = "hm_shop_token"; // token对应持久化的key
}

// 存放请求地址接口的常量
class HttpContants {
  static const String BANNER_LIST = "/home/banner"; // 轮播图请求地址
  static const String CATEGORY_LIST = "/home/category/head"; // 分类请求地址
  static const String PRODUCT_LIST = "/hot/preference"; // 特惠推荐请求地址
  static const String IN_VOGUE_LIST = "/hot/inVogue"; // 热榜推荐请求地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; // 一战式买全请求地址
  static const String RECOMMEND_LIST = "/home/recommend"; // 推荐列表请求地址
  static const String GUESS_LIST = "/home/goods/guessLike"; // 猜你喜欢请求地址
  static const String LOGIN = "/login"; // 登录接口地址
  static const String USER_PROFILE = "/member/profile"; // 用户信息接口地址
}