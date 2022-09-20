import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template_plus/common/my_init.dart';
import 'package:flutter_template_plus/db/my_cache.dart';
import 'package:flutter_template_plus/localization/current_locale_notifier.dart';
import 'package:flutter_template_plus/pages/change_language_page.dart';
import 'package:flutter_template_plus/pages/detail_page.dart';
import 'package:flutter_template_plus/pages/login_page.dart';
import 'package:flutter_template_plus/pages/navigator_page.dart';
import 'package:flutter_template_plus/pages/setting_dev/setting_page.dart';
import 'package:flutter_template_plus/provider/my_provider.dart';
import 'package:flutter_template_plus/provider/theme_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart';
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart';
import 'package:flutter_ume_kit_show_code/flutter_ume_kit_show_code.dart';
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart';
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // 网格线
  // debugPaintSizeEnabled = true;
  // Flutter 版本 (1.12.13+hotfix.5) 后，初始化插件必须加 ensureInitialized
  // WidgetsFlutterBinding.ensureInitialized();
  // 应用入口
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);

  await MyCache.preInit();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  if (kReleaseMode) {
    runApp(MyApp());
  } else {
    PluginManager.instance
      ..register(WidgetInfoInspector())
      ..register(WidgetDetailInspector())
      ..register(AlignRuler())
      ..register(TouchIndicator())
      ..register(Performance())
      ..register(ShowCode())
      ..register(DeviceInfoPanel())
      ..register(Console());
    runApp(UMEWidget(
      enable: true,
      child: MyApp(),
    ));
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // MyRouterDelegate _routerDelegate = MyRouterDelegate();
  @override
  void initState() {
    super.initState();
    // await FirebaseAnalytics.instance.logBeginCheckout(
    //     value: 10.0,
    //     currency: 'CN',
    //     items: [AnalyticsEventItem(itemName: 'Text', itemId: 'jia', price: 10.0)],
    //     coupon: '1234qwer');
  }

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) => NavigatorPage(),
          routes: <GoRoute>[
            GoRoute(path: 'detail', builder: (context, state) => DetailPage(id: 9876), routes: [
              GoRoute(
                path: 'setLanguage',
                builder: (context, state) => SettingLanguagePage(),
              ),
            ]),
            GoRoute(
              path: 'setLanguage',
              builder: (context, state) => SettingLanguagePage(),
            ),
            GoRoute(
              path: 'settingDev',
              builder: (context, state) => SettingPage(),
            )
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(),
        )
      ],
    );
    return FutureBuilder(
      // 进行项目的预初始化
      future: MyInit.init(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MultiProvider(
          providers: topProviders,

          // 这里通过 Consumer 读取数据，灵活度高
          // 还有其他的读取方式，比如 context.read<ThemeProvider>()
          child: Selector3<ThemeProvider, CurrentLocale, AppStatus, List>(
            selector: (context, p1, p2, p3) {
              return [p1, p2, p3];
            },
            shouldRebuild: (previous, next) {
              return previous != next;
            },
            builder: (
              BuildContext context,
              dynamic value,
              Widget? child,
            ) {
              Widget widget = snapshot.connectionState == ConnectionState.done
                  ? (value[2].isLogin ? NavigatorPage() : LoginPage())
                  // 初始化未完成时，显示 loading 动画
                  : Scaffold(body: Center(child: CircularProgressIndicator()));

              return MaterialApp.router(
                routerDelegate: goRouter.routerDelegate,
                routeInformationParser: goRouter.routeInformationParser,
                routeInformationProvider: goRouter.routeInformationProvider,
                title: 'flutter_template_plus',
                theme: value[0].getTheme(),
                darkTheme: value[0].getTheme(isDarkMode: true),
                themeMode: value[0].getThemeMode(),
                localizationsDelegates: [
                  // 本地化的代理类
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  S.delegate
                ],
                locale: value[1].value,
                supportedLocales: [
                  const Locale('en', 'US'), // 美国英语
                  const Locale('zh', 'CH') // 中文简体
                ],
                builder: EasyLoading.init(),
                // 设置 Router
                // home: widget,
              );
            },
          ),
        );
      },
    );
  }
}
