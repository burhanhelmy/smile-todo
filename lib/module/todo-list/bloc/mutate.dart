import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

enum TodoMutateEvent { delete, add, complete, incomplete }

class TodoMutateBloc extends Bloc<TodoMutateEvent, Function> {
  TodoMutateBloc() : super(() {});
  @override
  Stream<Function> mapEventToState(TodoMutateEvent event,
      {TodoModel todo}) async* {
    switch (event) {
      case TodoMutateEvent.delete:
        // Simulating Network Latency
        // await Future<void>.delayed(Duration(seconds: 1));
        yield () {};
        break;
      case TodoMutateEvent.add:
        _addTodo();
        // Simulating Network Latency
        // await Future<void>.delayed(Duration(milliseconds: 500));
        yield () {};
        break;
      case TodoMutateEvent.complete:
        // Simulating Network Latency
        // await Future<void>.delayed(Duration(milliseconds: 500));
        yield () {};
        break;
      case TodoMutateEvent.incomplete:
        // Simulating Network Latency
        // await Future<void>.delayed(Duration(milliseconds: 500));
        yield () {};
        break;
      default:
        addError(Exception('unhandled event: $event'));
    }
  }

  get _todoObject {
    return TodoModel(
        id: 1,
        title: "Automated Testing Script",
        startDate: "21 Oct 2019",
        estEndDate: "21 Oct 2019",
        done: false);
  }

  Future<List<TodoModel>> _addTodo() async {
    try {
      var todoProvider = TodoProvider();
      var databasesPath = await getDatabasesPath();
      String path = p.join(databasesPath, 'smile.db');
      await todoProvider.open(path);

      await todoProvider.insert(_todoObject);
      // return await todoProvider.getTodoList();
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
