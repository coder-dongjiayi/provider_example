import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Student with ChangeNotifier{
  Student({required this.name, required this.age});

  final String name;
  int age;

  void increaseAge() {
    this.age++;
    notifyListeners();
  }
}
class School with ChangeNotifier{
  School({required this.student});
  final Student student;

   String? get grade {
     if(student.age < 6){
       return student.name + "正在上幼儿园";
     }
     if(student.age >= 6 && student.age < 13){
       return student.name + "正在上小学";
     }
     if(student.age >= 14 && student.age < 16){
       return student.name + "正在上初中";
     }
     if(student.age >= 16 && student.age < 18){
       return student.name + "正在上高中";
     }
     return "张三已经毕业";
   }
}


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Student>(create: (_) => Student(name: '张三', age: 0)),
        ChangeNotifierProxyProvider<Student, School>(
          create: (BuildContext context){

            Student _student =   Provider.of<Student>(context, listen: false);

            return School(student:_student );
          },
          update: (BuildContext context, Student student, School? school){

            return School(student: student);
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proxy Provider'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '我是 ${context.select((School s) => s.student.name)}',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text('年龄: ${context.select((School s) => s.student.age)}'),
              Text(context.watch<School>().grade ?? ""),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Provider.of<Student>(context, listen: false).increaseAge();
          //Provider.of<Job>(context, listen: false).jonPrint();
        },
      ),
    );
  }
}
