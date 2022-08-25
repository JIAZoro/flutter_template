import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_template_plus/common/my_color.dart';
import 'package:flutter_template_plus/common/my_constants.dart';
import 'package:flutter_template_plus/db/my_cache.dart';

/// 扩展 ThemeMode
extension ThemeModeExtension on ThemeMode {
  // 这样就是可以通过 value 属性，获取对应的 String
  String get value => <String>['System', 'Light', 'Dark'][index];
}

/// 主题状态管理
class ThemeProvider extends ChangeNotifier {
  ThemeMode? _themeMode;

  // 判断是否是 Dark Mode（该方法用于页面上判断是否为 Dark Mode，然后切换样式）
  bool isDark() {
    if (_themeMode == ThemeMode.system) {
      // 获取系统的 Dark Mode
      return SchedulerBinding.instance?.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  // 获取主题模式
  ThemeMode getThemeMode() {
    String? themeMode = MyCache.getInstance().get(Constants.themeMode);
    switch (themeMode) {
      case 'System':
        _themeMode = ThemeMode.system;
        break;
      case 'Dark':
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.light;
        break;
    }
    return _themeMode!;
  }

  // 设置主题模式
  void setThemeMode(ThemeMode themeMode) {
    MyCache.getInstance().setString(Constants.themeMode, themeMode.value);
    // 主题模式改变后，需要通知所有订阅者
    notifyListeners();
  }

  // 获取主题
  ThemeData getTheme({bool isDarkMode = false}) {
    var themeData = ThemeData(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      errorColor: isDarkMode ? MyColor.dark_red : MyColor.light_red,
      scaffoldBackgroundColor: isDarkMode ? MyColor.dark_bg : MyColor.white,
      // colorScheme: ColorScheme.fromSwatch().copyWith(
      //   brightness: isDarkMode ? Brightness.dark : Brightness.light,
      //   primary: MyColor.primary,
      // ),
    );
    return themeData;
  }
}
