import 'package:flutter/material.dart';
import 'package:flutter_template_plus/db/my_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("开发设置"),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white30,
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("代理设置："),
                Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "输入代理端口，如：127.0.0.1:8080",
                        hintStyle: TextStyle(fontSize: 12, color: Colors.grey)),
                )),
                TextButton(onPressed:() async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString('proxy', _textEditingController.text);

                }, child: Text('保存代理'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
