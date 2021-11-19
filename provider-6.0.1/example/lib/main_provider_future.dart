// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme {
  String theme;
  late Color primaryColor;
  AppTheme({
    required this.theme,
  }) {
    _configTheme();
  }
  void _configTheme() {
    if (this.theme == "dark") {
      primaryColor = Colors.black;
    }
    if (this.theme == "light") {
      primaryColor = Colors.white;
    }
  }
  ///从服务器获取主题样式
  static Future<AppTheme> requestThemeStyle() async {
    Completer<AppTheme> _completer = Completer();

    ///模拟请求从服务获取当前出题样式
    await Future.delayed(Duration(seconds: 3), () {
      print(" 构造一个新的主题对象 用于更新当前正在显示的主题");
      AppTheme _theme = AppTheme(theme: "light");

      _completer.complete(_theme);
    }).catchError((_) {
      _completer.completeError("请求错误");
    });
    return _completer.future;
  }
}

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureProvider<AppTheme>(
     create: (context){
       return AppTheme.requestThemeStyle();
     },
      initialData: AppTheme(theme: "dark"),
      child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('provider'),
            ),
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: Builder(builder: (context) {
                        return ColoredBox(
                            color: Provider.of<AppTheme>(context, listen: true)
                                .primaryColor);
                      }),
                    )
                  ],
                )),

          )),
    );
  }
}
