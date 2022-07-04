import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflit_app/moduols/archive.dart';
import 'package:sqflit_app/moduols/done.dart';
import 'package:sqflit_app/moduols/tasks.dart';
import 'package:sqflit_app/shear/cubit/App_State.dart';
import 'package:sqflite/sqflite.dart';

class App_Cubit extends Cubit<App_State> {
  App_Cubit() : super(App_InatualState());

  static App_Cubit git(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.task,
        ),
        label: "Task"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.done,
        ),
        label: "Done"),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.archive,
        ),
        label: "Archives"),
  ];
  List<Widget> Screens = [
    const Tasks_Screen(),
    const Done_Screen(),
    const Archive_Screen(),
  ];

  List<Map> task = [];
  List<Map> done = [];
  List<Map> archive = [];

  List<String> whatisScreen = ["Tasks", "Done Task", "Archive Task"];

  TextEditingController titelcontrolar = TextEditingController();
  TextEditingController Timecontrolar = TextEditingController();
  TextEditingController Datelcontrolar = TextEditingController();

  List<Map> tasks = [];
  bool isnotopen = true;

  void isopen_change({bool? index}) {
    index == null ? isnotopen = !isnotopen : isnotopen = index;
    emit(isopen_change_State());
  }

  var scaffoldkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();

  int currentindex = 0;

  void currentindex_change(index) {
    currentindex = index;
    emit(currentindex_change_State());
  }

  Database? database;

  void createDatabase() async {
    database = await openDatabase("todo.db", version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, name TEXT, time TEXT, date TEXT,status TEXT)')
          .then((value) {
        print("Table _created");
      }).catchError((onError) {
        print(onError.toString());
      });
      print("database_crated");
    }, onOpen: (database) {

      Timer(Duration(milliseconds: 100),(){
       GetData();
      });
      print("Databese opened");

      emit(InsairtinDatabase());
    });
  }

  void insartinDatabase() {
    database!.transaction((txn) async {
      txn
          .rawInsert(
              "INSERT INTO tasks(name,time,date,status)VALUES('${titelcontrolar.text}','${Timecontrolar.text}','${Datelcontrolar.text}','new')")
          .then((value) {
        print("$value insart is true");

        emit(InsairtinDatabase());
      }).catchError((error) {
        print(error.toString());
      });
    });
  }

  void UpdateDatabase({
    required String status,
    required int id,
  }) {
    database!.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', '$id']).then((value) {
      GetData();
      emit(update_State());
      print(value.toString());
    }).catchError((error) {
      print(error.toString());
    });
  }

  void GetData() async{
    task = [];
    done = [];
    archive = [];
    emit(GetData_State());

    await database!.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          task.add(element);
        } else if (element['status'] == 'done') {
          done.add(element);
        } else {
          archive.add(element);
        }
      });

      emit(InsairtinDatabase());
      print(value.toString());
    }).then((value){
      print("done_all");
    });
  }



  void DeletefromDatabase({required int id,}){
database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
  print(value.toString()+"Sucsess");
  GetData();
  print("Sucsess");
  emit(DeletefromDatabase_State());

});

  }
}
