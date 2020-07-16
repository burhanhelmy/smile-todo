import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:smile_todo/module/todo-list/bloc/list.dart';
import 'package:smile_todo/module/todo-list/bloc/mutate.dart';

import 'package:smile_todo/module/todo-list/screen/new-edit-todo.dart';
import 'package:smile_todo/module/todo-list/widget/todo-card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: BlocListener(
          bloc: _todoMutateBloc,
          listener: (BuildContext context, state) {
            if (state is TodoUpdated) {
              context.bloc<TodoListBloc>().add(TodoListEvent.fetch);
            }
            if (state is TodoDeleted) {
              Get.snackbar("One todo deleted", "In the dust bin",
                  snackPosition: SnackPosition.TOP,
                  duration: Duration(seconds: 5));
              context.bloc<TodoListBloc>().add(TodoListEvent.fetch);
            }
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
            floatingActionButton: BlocBuilder<TodoMutateBloc, TodoMutateState>(
                builder: (context, todoList) {
              return FloatingActionButton(
                backgroundColor: Colors.red[500],
                onPressed: () async {
                  await Get.to(NewOrEditTodoScreen(
                    isNew: true,
                  )).then((value) =>
                      {context.bloc<TodoListBloc>().add(TodoListEvent.fetch)});
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  _renderList() {
    return BlocBuilder<TodoListBloc, List<TodoModel>>(
        builder: (context, todoList) {
      return todoList.length > 0
          ? ListView.builder(
              padding:
                  EdgeInsets.only(top: 10, bottom: 80, left: 10, right: 10),
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TodoCard(todoList[index], () {
                    Get.to(NewOrEditTodoScreen(
                      todo: todoList[index],
                      isNew: false,
                    )).then((value) => _todoListBloc.add(TodoListEvent.fetch));
                  }),
                );
              })
          : Center(child: Text("Start to be productive now :)"));
    });
  }
}
