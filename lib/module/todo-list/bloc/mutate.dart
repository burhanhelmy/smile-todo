import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:equatable/equatable.dart';

// class TodoMutateAction { delete, add, complete, incomplete }
abstract class TodoMutateEvent extends Equatable {
  const TodoMutateEvent();
}

abstract class TodoMutateState extends Equatable {
  @override
  List<Object> get props => [];
}

class CompletePressed extends TodoMutateEvent {
  final TodoModel todo;

  const CompletePressed({
    @required this.todo,
  });

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'CompletePressed { todo: $todo }';
}

class AddPressed extends TodoMutateEvent {
  final TodoModel todo;

  const AddPressed({
    @required this.todo,
  });

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'AddPressed { todo: $todo }';
}

class SavePressed extends TodoMutateEvent {
  final TodoModel todo;

  const SavePressed({
    @required this.todo,
  });

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'SavePressed { todo: $todo }';
}

class DeletePressed extends TodoMutateEvent {
  final TodoModel todo;

  const DeletePressed({
    @required this.todo,
  });

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'DeletePressed { todo: $todo }';
}

class AddSucess extends TodoMutateState {}

class TodoUpdated extends TodoMutateState {}

class TodoDeleted extends TodoMutateState {}

class Initial extends TodoMutateState {}

class TodoMutateBloc extends Bloc<TodoMutateEvent, TodoMutateState> {
  TodoMutateBloc() : super(Initial());
  @override
  Stream<TodoMutateState> mapEventToState(TodoMutateEvent event) async* {
    if (event is AddPressed) {
      await _addTodo(event.todo);
      yield AddSucess();
    } else if (event is CompletePressed) {
      await _updateTodo(event.todo);
      yield TodoUpdated();
    } else if (event is SavePressed) {
      await _updateTodo(event.todo);
      yield TodoUpdated();
    } else if (event is DeletePressed) {
      await _deleteTodo(event.todo);
      yield TodoDeleted();
    }
  }
}

Future _addTodo(todo) async {
  try {
    var todoProvider = TodoProvider();
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'smile.db');
    await todoProvider.open(path);

    await todoProvider.insert(todo);
    // return await todoProvider.getTodoList();
  } catch (e) {
    print(e.toString());
  }
}

Future _deleteTodo(TodoModel todo) async {
  try {
    var todoProvider = TodoProvider();
    await todoProvider.delete(todo.id);
  } catch (e) {
    print(e.toString());
  }
}

Future _updateTodo(todo) async {
  try {
    var todoProvider = TodoProvider();
    await todoProvider.update(todo);
  } catch (e) {
    print(e.toString());
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
