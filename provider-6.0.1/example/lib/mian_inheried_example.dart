// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Person{
  Person({required this.name,required this.age});
  final String name;
  final int age;
}

class InheritedProviderScope<T> extends InheritedWidget{
  InheritedProviderScope({Key? key, required Widget child,required this.value}) : super(key: key,child : child);
   final T value;
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {

    return true;
  }

  static T of<T>(BuildContext context,{bool listener = true}){
    if(listener == true){
      context.dependOnInheritedWidgetOfExactType<InheritedProviderScope<T>>();
    }
    InheritedElement? element =  context.getElementForInheritedWidgetOfExactType<InheritedProviderScope<T>>();
    InheritedProviderScope<T> _widget = element!.widget as InheritedProviderScope<T>;
    return _widget.value;
  }
  
}

class MyBuilder extends StatefulWidget {
  const MyBuilder({Key? key,required this.builder}) : super(key: key);
  final WidgetBuilder builder;
  @override
  _MyBuilderState createState() => _MyBuilderState();
}

class _MyBuilderState extends State<MyBuilder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) => widget.builder(context);
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies 执行");
  }
}



void main() {
  runApp(
      MyApp()

  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  @override
  Widget build(BuildContext context) {

    return   InheritedProviderScope<Person>(child:  MaterialApp(
        themeMode: ThemeMode.light,
        home:  Scaffold(
          appBar: AppBar(
            title: const Text('provider'),
          ),

          body: Center(

              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyBuilder(builder: (context){
                    Person _person = InheritedProviderScope.of(context);
                    return Text("name:${_person.name}");
                  }),
                  MyBuilder(builder: (context){
                    Person _person = InheritedProviderScope.of(context);
                    return Text("age:${_person.age}");
                  })
                ],
              )

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              setState(() {

              });
            },
          ),

        )
    ),value: Person(name: "张三",age: 18));

  }
}



