import 'package:flutter/material.dart';
import 'package:flutter_template_plus/generated/l10n.dart';
import 'package:flutter_template_plus/pages/change_language_page.dart';

class DetailPage extends StatefulWidget {
  final int id;

  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).detail),
      ),
      body: Column(
        children: [
          Center(
            child: Text('传递过来的id数据: ${widget.id}'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return SettingLanguagePage();
                }));
              },
              child: Text(S.current.set_language)),
        ],
      ),
    );
  }
}
