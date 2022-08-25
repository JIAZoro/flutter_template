import 'package:flutter_template_plus/localization/current_locale_notifier.dart';
import 'package:flutter_template_plus/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> topProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => CurrentLocale()),
  ChangeNotifierProvider(create: (_) => AppStatus()),
];
