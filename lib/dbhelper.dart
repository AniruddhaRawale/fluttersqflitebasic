//reason to create database helper class
// because we can capsulate all the functions inside the class
//and later we can refer to that class to call further crud operations for
//that database

//we have to make this class a singleton class because
//for the whole life cycle we want only one instance of database
//easiest way to do is to create a private constructor
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
//to use join
import 'package:path/path.dart';

class DatabaseHelper{

  //we need to create varibles before initializing db
//whenever you create a variable always use.db extension
//this helps app to realise its database
//database always automatically finds out
// in variable which kinda data is this

static final _dbname = 'myDatabase.db';
static final _DataBase_Version = 1 ;
static final _tablename = 'myTable';

//this will help in giving name and value to column
  //this will create two columns
  static final columnId = '_id';
  static final columnName = "name";



  //creating private constructor
  DatabaseHelper._privateConstructor();
  //to create static final so nobody can change
//once initiated
  //whole application lifecycle will only have one instance
  //of this database
static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//created instance

//to initialize database
//return type of database is database

  //we are creating everything static because we want it to be
  //accesed by the class

  //this data base is null before anyactual value added
static Database _database;

//we are creating a gator future because value will be null in
//present and it will be added in future

  //async because dat may take some time to arrive

  //this function will return database
  //ie above var as return

  //TODO working of the database in below future database function
  //if the database is not null return a database
  //if database is null initiate  a database function
  //it will initial database function in this function we are creating
  //add new directories we are joining the path
  // and then we are opening the database
  //this opens database function whch in turns returns database
  //which was created

Future<Database> get database async{
 if(_database!=null) return _database;

 //creating local directory to store data locally
 //it will initate database if itis found null according to above
 //condition
  _database = await _initiateDatabase();
  return database;
}

_initiateDatabase() async{
//to i/p or o/p data we use dart.io
  //get application directory is  used to get documentss  directory
  //ie location link in general
  //we also have downloads directory


  Directory directory = await getApplicationDocumentsDirectory();

  //path location + file name
  //join will join file name with path directory
  String path = join(directory.path,_dbname);
  //opening database will open the database
  // and initialize it eventually
  //await because it will take some time to load
  //we have to give the path of db to the opendatabase because
  //so it would realize where to find database

  //oncrreate is what to do as soon as you create db
  return await openDatabase(path, version: _DataBase_Version,onCreate: _onCreate );

  //we have to give databse version
  //to keep track of which version to use
  // because as the database increases complexity increases
  //and version will increase so for simplicity do this

}
//oncreate will take two i/p one is database second is version
  //once database is created we have to create a new table hence
  //to do this we have to create a query first
  Future _onCreate(Database db, int version){
  //we created table name now we have to give heading to columns
  db.execute(

    '''
    CREATE TABLE $_tablename(
     $columnId INTEGER PRIMERY KEY,
    $columnName TEXT NOT NULL )
    
    '''

  );
  }
 /* {
    //query will return a list of maps
// means data base  value will be like
//key value pair
  '_id' :12,
  "name":"Saheb"
}*/

 //the data to be inserted should be in terms of maps
 Future<int> insert(Map<String,dynamic>row) async{
//to get database
//once we will call this function it will
 //call future getter function and it will
   //instantantiate function which will
   //create database
 Database db = await instance.database;
 ///to get primary key we have to return it
 return await db.insert(_tablename, row);

 }

 //to get all values back in row
  //return type will be list of maps
 Future<List<Map<String,dynamic>>> queryAll() async{
   Database db = await instance.database;
   return await db.query(_tablename);

 }

 //to update
  //we need to give location and value to update first
  //int => no. of rows to be updated
 Future<int> update (Map<String,dynamic>row) async{
   Database db = await instance.database;
   int id = row[columnId];

   return await db.update(_tablename, row,where: '$columnId = ? $columnName = ?' , whereArgs: [columnId,columnName] );
   //where=> where exactly in which location you want to update
   // data in column and row
   //? is  used to tell that we are going to add value in it
   //when you put value in whereArgs[]
   // it will take value based on which data is  added first
   // ie on question marks and its location ex here column id is first
   //and column name is second
   //to leave the  question part as it might be confusing sometimes you
   //can directly add id in whereargs ex whereargs[id] and
   // add int id = row[column id] we will be fetching id of the row

 }
 //to delete
 //just delete the record which has this id
 Future<int> delete(int id) async{
   Database db = await instance.database;
   return await db.delete(_tablename,where:'$columnId =?',whereArgs: [id]);
 }


}