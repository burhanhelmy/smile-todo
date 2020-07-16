import 'package:sqflite/sqflite.dart';

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';
final String columnStartDate = 'startDate';
final String columnEstEndDate = 'estEndDate';

class TodoModel {
  int id;
  String title;
  String startDate;
  String estEndDate;
  bool done;

  TodoModel({this.id, this.title, this.startDate, this.estEndDate, this.done});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnStartDate: startDate,
      columnEstEndDate: estEndDate,
      columnTitle: title,
      columnDone: done == true ? 1 : 0
    };
    // if (id != null) {
    //   map[columnId] = id;
    // }
    return map;
  }

  TodoModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
  }
}

class TodoProvider {
  static final TodoProvider _singleton = TodoProvider._internal();

  factory TodoProvider() => _singleton;

  TodoProvider._internal(); // private constructor
  Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'create table $tableTodo ( $columnId integer primary key autoincrement, $columnDone integer not null, $columnTitle text not null, $columnStartDate text not null, $columnEstEndDate text not null)');
    });
  }

  Future<TodoModel> insert(TodoModel todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());
    return todo;
  }

  Future<TodoModel> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return TodoModel.fromMap(maps.first);
    }
    return null;
  }

  Future<List<TodoModel>> getTodoList() async {
    List<Map> maps = await db.query(tableTodo);
    if (maps.length > 0) {
      return maps.map((e) => TodoModel.fromMap(e)).toList();
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(TodoModel todo) async {
    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
