class TranslationModel {
  late String login;
  late String hi;
  late String no_account;
  late String register;
  late String email;
  late String pass;
  late String username;
  late String phone;
  late String yse_account;
  late String loginerror;
  late String logindone;
  late String loginload;
  late String updatedata;
  late String uploaditem;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    hi = json['hi'];
    no_account = json['no_account'];
    register = json['register'];
    email = json['email'];
    pass = json['pass'];
    username = json['username'];
    phone = json['phone'];
    yse_account = json['yse_account'];
    loginerror = json['loginerror'];
    logindone = json['logindone'];
    loginload = json['loginload'];
    updatedata = json['updatedata'];
    uploaditem = json['uploaditem'];
  }
}