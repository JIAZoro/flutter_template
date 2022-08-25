import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template_plus/generated/l10n.dart';
import 'package:flutter_template_plus/localization/current_locale_notifier.dart';
import 'package:provider/provider.dart';

class SettingLanguagePage extends StatefulWidget {
  const SettingLanguagePage({Key? key}) : super(key: key);

  @override
  State<SettingLanguagePage> createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.set_language),
      ),
      body: Column(
        children: [
          OutlinedButton(
              onPressed: () {
                // Set local
                Provider.of<CurrentLocale>(context, listen: false)
                    .setLocale(Locale('en', 'US'));
                Navigator.of(context).pop();
              },
              child: Text(S.current.english)),
          OutlinedButton(
              onPressed: () {
                // Set local
                Provider.of<CurrentLocale>(context, listen: false)
                    .setLocale(Locale('zh', 'CN'));
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).chinese)),
        ],
      ),
    );
  }
}
