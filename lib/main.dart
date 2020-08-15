import 'package:database_concept/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "Database Tutorial",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQFlite Example"),),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            FlatButton(onPressed: () async{

             int i = await DatabaseHelper.instance.insert({
                DatabaseHelper.columnName : 'Saheb',
               DatabaseHelper.columnId : 12
              });

             print("the inserted id is $i");

            }, child: Text("Insert"),color: Colors.blueGrey,),
            FlatButton(onPressed: () async{
              List<Map<String,dynamic>>queryRows = await DatabaseHelper.instance.queryAll();
              print(queryRows);


            }, child: Text("Query"),color: Colors.blueGrey,),

            FlatButton(onPressed: () async{
              int updatedId = await DatabaseHelper.instance.update({
               DatabaseHelper.columnId:12,
                DatabaseHelper.columnName: "Mark"
              });
              print(updatedId);
            },
            child: Text("Update"),color: Colors.blueGrey,),
            FlatButton(onPressed: () async{
              int rowsEffected = await DatabaseHelper.instance.delete(13);
              print(rowsEffected);

            }, child: Text("Delete"),color: Colors.blueGrey,),
          ],
        ),
      ),
    );
  }
}

