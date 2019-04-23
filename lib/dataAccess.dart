import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'todoItem.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

final String todoTable = "TodoItems";

class DataAccess {
  static final DataAccess _instance = DataAccess._internal();
  Database _db;

  factory DataAccess() {
    return _instance;
  }

  DataAccess._internal();

  Future open() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todo.db';

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table $todoTable ( 
            id integer primary key autoincrement, 
            name text not null,
            isComplete integer not null)
            ''');
        });
    // This is just a convenience block to populate the database if it's empty.
    // We likely wouldn't use this in a real application
    if((await getTodoItems()).length == 0) {
      insertTodo(TodoItem(name: "Test1 Task", isComplete: true));
      insertTodo(TodoItem(name: "Test2 Task"));
      insertTodo(TodoItem(name: "Test3 Task"));
    }
  }

  Future<List<TodoItem>> getTodoItems() async {
    var data = await _db.query(todoTable);
    return data.map((d) => TodoItem.fromMap(d)).toList();
  }

  Future insertTodo(TodoItem item) {
    return _db.insert(todoTable, item.toMap());
  }

  Future updateTodo(TodoItem item) {
    return _db.update(todoTable, item.toMap(),
        where: "id = ?", whereArgs: [item.id]);
  }

  Future deleteTodo(TodoItem item) {
    return _db.delete(todoTable, where: "id = ?", whereArgs: [item.id]);
  }
}