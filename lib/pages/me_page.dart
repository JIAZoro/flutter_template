import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template_plus/generated/l10n.dart';
import 'package:flutter_template_plus/http/dao/login_dao.dart';
import 'package:flutter_template_plus/localization/current_locale_notifier.dart';
import 'package:flutter_template_plus/pages/change_language_page.dart';
import 'package:flutter_template_plus/pages/login_page.dart';
import 'package:flutter_template_plus/provider/theme_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).my),
      ),
      body: ListView(
        padding: EdgeInsets.only(
          left: 35,
          right: 35,
        ),
        children: [
          OutlinedButton(
              onPressed: () {
                // MyNavigator.getInstance().onJumpTo(RouteStatus.settingLanguage);
                // Navigator.of(context).push(
                //   new MaterialPageRoute(
                //       builder: (context) => new SettingLanguagePage()),
                // );
                context.go('/setLanguage');
              },
              child: Text(S.of(context).set_language)),
          OutlinedButton(
            child: Text(S.of(context).light_model),
            onPressed: () {
              context.read<ThemeProvider>().setThemeMode(ThemeMode.light);
            },
          ),
          OutlinedButton(
            child: Text(S.of(context).dark_mode),
            onPressed: () async {
              context.read<ThemeProvider>().setThemeMode(ThemeMode.dark);
            },
          ),
          OutlinedButton(
            child: Text(S.of(context).system),
            onPressed: () {
              context.read<ThemeProvider>().setThemeMode(ThemeMode.system);
            },
          ),
          ElevatedButton(
            child: Text(S.of(context).exit_user),
            onPressed: () {
              LoginDao.removeToken();
              Provider.of<AppStatus>(context, listen: false).updateAppStatus();
            },
          ),
          Visibility(
              visible: !kReleaseMode,
              child: OutlinedButton(
                child: Text("开发设置"),
                onPressed: () {
                  context.go('/settingDev');
                },
              ))
        ],
      ),
    );
  }
}
