import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template_plus/generated/l10n.dart';
import 'package:flutter_template_plus/http/core/my_net_error.dart';
import 'package:flutter_template_plus/http/dao/login_dao.dart';
import 'package:flutter_template_plus/localization/current_locale_notifier.dart';
import 'package:flutter_template_plus/widgets/login_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController(text: 'admin');
  TextEditingController _passwordController =
      TextEditingController(text: '12345678');
  // '记住密码' 复选框
  bool? _savePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ListView 可以自适应键盘，防止键盘弹起后遮挡
      body: ListView(
        padding: EdgeInsets.only(
          top: 70,
          left: 35,
          right: 35,
        ),
        children: [
          Image.asset(
            'assets/images/login/logo.png',
            width: 200,
            height: 200,
          ),
          _form(),
          _save(),
          _button(),
        ],
      ),
    );
  }

  // 表单
  Widget _form() {
    return Form(
      // 设置 globalKey，用于后面获取 FormState
      key: _formKey,
      // 不开启自动校验表单，而是选择在点击登录按钮时校验
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: LoginInput(
              '请输入用户名',
              Icon(Icons.perm_identity),
              _userController,
              validator: (value) {
                return value!.trim().length > 0 ? null : "用户名不能为空";
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: LoginInput(
              '请输入密码',
              Icon(Icons.lock_outline),
              _passwordController,
              obscureText: true,
              validator: (value) {
                return value!.trim().length >= 8 ? null : "密码不能少于8位";
              },
            ),
          ),
        ],
      ),
    );
  }

  // 记住密码
  _save() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Checkbox(
            value: _savePassword,
            onChanged: (value) {
              setState(() {
                _savePassword = value;
              });
            },
          ),
          Text(S.current.rember_password),
        ],
      ),
    );
  }

  // 登录按钮
  Widget _button() {
    return FractionallySizedBox(
      // 子元素占父元素的宽度比例
      widthFactor: 0.6,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          child: Text(S.current.login),
          style: ElevatedButton.styleFrom(
            // 圆角
            shape: StadiumBorder(),
          ),
          onPressed: () async {
            if ((_formKey.currentState as FormState).validate()) {
              // 验证通过提交数据
              EasyLoading.show();
              try {
                await LoginDao.login(
                  _userController.text.trim(),
                  _passwordController.text.trim(),
                );
                EasyLoading.dismiss();
                Provider.of<AppStatus>(context, listen: false).setIsLogin(true);
              } on MyNetError catch (e) {
                // 请求发生异常
                EasyLoading.showError(e.message);
              } catch (e) {
                // 其他代码异常
                EasyLoading.showError(e.toString());
              }
            }
          },
        ),
      ),
    );
  }
}
