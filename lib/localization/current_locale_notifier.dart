import 'package:flutter/material.dart';
import 'package:flutter_template_plus/common/my_constants.dart';
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
  bool _isLogin =
      MyCache.getInstance().get(Constants.token) != null ? true : false;
  bool get isLogin => _isLogin;

  /// 根据村粗判断登陆状态
  void updateAppStatus() {
    if (MyCache.getInstance().get(Constants.token) != null) {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
    notifyListeners();
  }
}
