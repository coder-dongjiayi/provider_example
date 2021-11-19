// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Person extends ChangeNotifier{
  Person({required this.name,required this.age});

  late String name;
  late int age;
  void addAge(){
    age++;
    notifyListeners();
  }
}
void main() {
  runApp(
      ChangeNotifierProvider(create: (BuildContext context){
        return Person(name: "张三",age: 12);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<Person>(builder: (context,person,widget){
                    print("我的名字");
                    return Text("我的名字:${person.name}");
                  }),
                  Consumer<Person>(builder: (context,person,widget){
                    print("我的年龄");
                    return Text("我的的年龄:${person.age.toString()}");
                  })
                ],
              )
            ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Provider.of<Person>(context,listen: false).addAge();
            },
          ),
        )
    );
  }
}



