import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:smile_todo/module/todo-list/bloc/list.dart';
import 'package:smile_todo/module/todo-list/bloc/mutate.dart';

import 'package:smile_todo/module/todo-list/screen/new-edit-todo.dart';
import 'package:smile_todo/module/todo-list/widget/todo-card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class TodoListScreen extends StatefulWidget {
//   @override
//   _TodoListScreenState createState() => _TodoListScreenState();
// }

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoListBloc _todoListBloc;
  TodoMutateBloc _todoMutateBloc;

  @override
  void initState() {
    _todoListBloc = TodoListBloc();
    _todoListBloc.add(TodoListEvent.fetch);
    _todoMutateBloc = TodoMutateBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return _todoListBloc;
      },
      child: BlocProvider(
        create: (BuildContext context) {
          return _todoMutateBloc;
        },
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
              title: Text(
                "To-Do List",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: false),
          body: _renderList(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BlocBuilder<TodoMutateBloc, Function>(
              builder: (context, todoList) {
            return FloatingActionButton(
              backgroundColor: Colors.red[500],
              onPressed: () {
                context.bloc<TodoMutateBloc>().add(TodoMutateEvent.add);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            );
          }),
        ),
      ),
    );
  }

  _renderList() {
    return BlocBuilder<TodoListBloc, List<TodoModel>>(
        buildWhen: (previousState, state) {
      return previousState != state;
      // return true/false to determine whether or not
      // to rebuild the widget with state
    }, builder: (context, todoList) {
      log("rebuild");
      // context.bloc<TodoListBloc>().add(TodoListEvent.fetch);
      return ListView.builder(
          padding: EdgeInsets.only(top: 10, bottom: 80, left: 10, right: 10),
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TodoCard(todoList[index], () {
                Get.to(NewOrEditTodoScreen(
                  todo: todoList[index],
                  isNew: false,
                ));
              }),
            );
          });
    });
  }
}
