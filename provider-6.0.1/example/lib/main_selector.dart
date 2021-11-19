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
    "s".codeUnitAt(0);
    age++;
    notifyListeners();
  }
  //ASCII



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
            title: const Text('selector provider'),
          ),
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                    Builder(builder: (context){
                      print("我的名字");
                     String _name = context.select<Person,String>((person) => person.name);
                      return Text("我的名字:${_name}");

                    }),
                  Builder(builder: (context){
                    print("我的年龄");
                    int _age = context.select<Person,int>((person) => person.age);
                    return Text("我的年龄:${_age.toString()}");
                  }),
                  // Selector<Person,String>(builder: (context,name,widget){
                  //   print("我的名字");
                  //   return Text("我的名字:${name}");
                  // }, selector: (context,person){
                  //   return person.name;
                  // }),
                  // Selector<Person,int>(builder: (context,age,widget){
                  //   print("我的年龄");
                  //   return Text("我的年龄:${age.toString()}");
                  // }, selector: (context,person){
                  //   return person.age;
                  // })
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



