import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smile_todo/module/todo-list/model.dart';

enum TodoListEvent { fetch }

class TodoListBloc extends Bloc<TodoListEvent, List<TodoModel>> {
  TodoListBloc() : super([]);
  List<TodoModel> todoList = [];
  @override
  Stream<List<TodoModel>> mapEventToState(TodoListEvent event,
      {TodoModel todo}) async* {
    switch (event) {
      case TodoListEvent.fetch:
        todoList.add(todoObject);
        print(todoList.length.toString());
        yield List.from(todoList);
        break;
      default:
        addError(Exception('unhandled event: $event'));
    }
  }

  get todoObject {
    return TodoModel(
        title: "Automated Testing Script",
        startDate: "21 Oct 2019",
        estEndDate: "21 Oct 2019",
        completed: false);
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
