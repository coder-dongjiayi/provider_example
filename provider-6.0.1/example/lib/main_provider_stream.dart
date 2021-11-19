import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
void main() {
  runApp(
      MyApp()
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _StatelessWidgetState createState() => _StatelessWidgetState();
}
class _StatelessWidgetState extends State<MyApp> {
 late StreamController<int> _streamController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController = StreamController.broadcast();


  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:  StreamProvider<int>.value(value: _streamController.stream,
        initialData: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Stream Provider"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Builder(builder: (context){
              return Center(
                child: Text(Provider.of<int>(context).toString()),
              );
            }),
          ),
          floatingActionButton: Builder(builder: (context){
            return FloatingActionButton(
              onPressed: (){
                int count =  Provider.of<int>(context,listen: false);
                int result = count + 1;
                _streamController.add(result);
              },
            );
          })
        ),
      ),
    );
  }
}

