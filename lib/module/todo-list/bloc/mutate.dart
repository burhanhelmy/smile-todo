import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smile_todo/module/todo-list/model.dart';

enum TodoMutateEvent { delete, add, complete, incomplete }

class TodoAddEditBloc extends Bloc<TodoMutateEvent, Function> {
  TodoAddEditBloc() : super(() {});
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
