import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final DatabaseReference database = FirebaseDatabase.instance.reference();

  Stream<Event> get stream {
    print("stream got a data");
    return database.onValue;
  }

  void _writeData () async {
    database.child(".info").once().then((data) {
      print(".info = ${data.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("test"),
          ),
          body: Center(
            child: Container(
              color: Colors.blue,
              child: FlatButton(
                onPressed: _writeData,
              ),
            ),
          ),
        );
      }
    );
  }
}