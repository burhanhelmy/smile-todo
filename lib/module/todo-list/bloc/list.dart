import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

enum TodoListEvent { fetch }

class TodoListBloc extends Bloc<TodoListEvent, List<TodoModel>> {
  TodoListBloc() : super([]);
  List<TodoModel> todoList = [];
  @override
  Stream<List<TodoModel>> mapEventToState(TodoListEvent event,
      {TodoModel todo}) async* {
    switch (event) {
      case TodoListEvent.fetch:
        todoList = await _loadTodo();
        if (todoList != null) {
          yield List.from(todoList);
        } else {
          yield [];
        }
        break;
      default:
        addError(Exception('unhandled event: $event'));
    }
  }

  Future<List<TodoModel>> _loadTodo() async {
    try {
      var todoProvider = TodoProvider();
      var databasesPath = await getDatabasesPath();
      String path = p.join(databasesPath, 'smile.db');
      await todoProvider.open(path);
      return await todoProvider.getTodoList();
    } catch (e) {
      print(e.toString());
    }
    // return [];
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('bloc: ${bloc.runtimeType}, event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('bloc: ${bloc.runtimeType}, transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }
}
