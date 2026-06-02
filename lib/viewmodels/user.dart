// 登录类型的工厂函数
class UserInfo {
  String account;
  String avatar;
  String birthday;
  String cityCode;
  String gender;
  String id;
  String mobile;
  String nickname;
  String profession;
  String provinceCode;
  String token;

  UserInfo({
    required this.account,
    required this.avatar,
    required this.birthday,
    required this.cityCode,
    required this.gender,
    required this.id,
    required this.mobile,
    required this.nickname,
    required this.profession,
    required this.provinceCode,
    required this.token,
  });
  // 一般工厂函数的Map就是用来传递数据给Getx的
  factory UserInfo.fromJSON(Map<String, dynamic> json) => UserInfo(
    account: json["account"] ?? "",
    avatar: json["avatar"] ?? "",
    birthday: json["birthday"] ?? "",
    cityCode: json["cityCode"] ?? "",
    gender: json["gender"] ?? "",
    id: json["id"] ?? "",
    mobile: json["mobile"] ?? "",
    nickname: json["nickname"] ?? "",
    profession: json["profession"] ?? "",
    provinceCode: json["provinceCode"] ?? "",
    token: json["token"] ?? "",
  );
}
