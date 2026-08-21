// 基于Dio进行二次封装
import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';

class DioRequest {
  // 创建Dio对象，接下来的请求，拦截器设置全在这里面完成
  final _dio = Dio();
  // 在构造函数里写入基础地址，超时时间，拦截器
  DioRequest() {
    _dio.options.baseUrl = GlobalContants.BASE_URL; // 配置基础地址
    _dio.options.connectTimeout = GlobalContants.TIME_OUT; // 请求超时
    _dio.options.sendTimeout = GlobalContants.TIME_OUT; // 发送超时
    _dio.options.receiveTimeout = GlobalContants.TIME_OUT; // 接收超时
    //拦截器
    _addInterceptor();
  }

  //添加拦截器
  void _addInterceptor() {
    // 这样就是定义拦截器的步骤
    _dio.interceptors.add(
      InterceptorsWrapper(
        //请求拦截
        onRequest: (request, handler) {
          // 一般在这里注入token，用gettoken工具获取磁盘上的数据
          // 判断磁盘中有数据才进行获取操作
          final token = tokenManager.getToken();
          if (token.isNotEmpty) {
            // 一般使用request中的headers Authorazation Bearer token来获取token，这种是企业公式的写法
            request.headers["Authorization"] = "Bearer $token";
          }
          handler.next(request); //通过
        },
        //响应拦截
        onResponse: (response, handler) {
          //进行http状态码判断大于200且小于300则成功
          //response.statusCode为http状态码，可能为空
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          //若不对则拦截。注意拦截的写法
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        //错误拦截
        // handler.reject(error); //有错误就拦截
        // 原来的异常抛出没有携带信息，改变方法使其能携带信息
        onError: (DioException error, ErrorInterceptorHandler handler) {
          // 断网、超时时 error.response 可能为 null，
          // data 也可能是 String/List 而不是 Map，需要安全取值，
          // 避免在异常处理里再次抛异常。
          handler.next(
            DioException(
              requestOptions: error.requestOptions,
              response: error.response,
              type: error.type,
              error: error.error,
              message: _readErrorMessage(error),
            ),
          );
        },
      ),
    );
  }

  // 从错误响应中安全读取后端返回的 msg
  String _readErrorMessage(DioException error) {
    final data = error.response?.data;
    if (data is Map) {
      final msg = data["msg"];
      if (msg != null && msg.toString().isNotEmpty) {
        return msg.toString();
      }
    }
    return "网络请求失败，请稍后重试";
  }

  // 定义一个get方法，请求数据
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 定义一个post方法
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  // 进一步处理返回结果的函数，对数据的二次处理
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      // Future是一个还未完成未来要完成的请求，所以task不是数据是一个请求
      Response<dynamic> res = await task; // 得到数据
      final data = res.data as Map<String, dynamic>; // 得到真实需要的接口返回的json数据
      // 业务状态判断
      if (data["code"] == GlobalContants.SUCCESS_CODE) {
        // 这样才认定业务状态与http状态均正常，就可以正常放行
        return data["result"]; //所有接口均只要result结果
      }
      // 判断为else则抛出异常
      // throw Exception(data["msg"] ?? "加载出现异常"); // ??空判断
      throw DioException(
        requestOptions: res.requestOptions,
        message: data["msg"] ?? "数据加载异常",
      );
    } catch (e) {
      // throw Exception(e);用这个方法会覆盖掉信息
      rethrow; // 不改变原来抛出异常的类型
    }
  }

  // 最后用try/catch保证逻辑的正常执行，与python一样
}

// 创建对象,方便外部调用
final DioRequest dioRequest = DioRequest(); // 单例对象

// dio请求工具发送请求，返回的数据类型却是Response<dynamic>，需要的数据存在Response<dynamic>.data中
// 为了不用每次获取数据都需要data，所有要把所有的接口解放出来，也就是解构或者对数据的二次处理
// 这样就可以拿到真正的数据，再判断请求是否成功，状态码是否为1
