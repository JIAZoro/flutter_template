import 'package:flutter/material.dart';
import 'package:flutter_template_plus/db/my_cache.dart';
import 'package:flutter_template_plus/http/dao/login_dao.dart';

class CurrentLocale with ChangeNotifier {
  Locale _locale = Locale('zh', 'CN');

  Locale get value => _locale;

  void setLocale(locale) {
    _locale = locale;
    notifyListeners();
  }
}

class AppStatus with ChangeNotifier {
  bool _isLogin = LoginDao.getToken() != null ? true : false;
  bool get isLogin => _isLogin;
  void setIsLogin(bool login) {
    _isLogin = login;
    notifyListeners();
  }
}
