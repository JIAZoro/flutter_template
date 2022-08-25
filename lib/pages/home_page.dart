import 'package:flutter/material.dart';
import 'package:flutter_template_plus/generated/l10n.dart';
import 'package:flutter_template_plus/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // 记得销毁监听
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).home),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text(S.current.jump_detail),
          onPressed: () {
            // MyNavigator.getInstance().onJumpTo(
            //   RouteStatus.detail,
            //   args: {'id': 9527},
            // );
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return DetailPage(id: 1234);
              },
            ));
          },
        ),
      ),
    );
  }
}
