// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme{
  final String theme;
  late   Color primaryColor;
  AppTheme({
    required this.theme,
 }){
     if(this.theme == "dark"){
       primaryColor = Colors.black;
     }
     if(this.theme == "light"){
       primaryColor = Colors.white;
     }
  }
}
void main() {
  runApp(
      Provider(create: (BuildContext context){
        return AppTheme(theme: "dark");
      },
        child: MyApp(),
      )
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Scaffold(
        appBar: AppBar(
          title: const Text('provider'),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: ColoredBox(color: Provider.of<AppTheme>(context,listen: true).primaryColor),
          ),
        )
      )
    );
  }
}



