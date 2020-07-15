import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_todo/module/todo-list/screen/new-edit-todo.dart';
import 'package:smile_todo/module/todo-list/widget/todo-card.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          title: Text(
            "To-Do List",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: false),
      body: _renderList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[500],
        onPressed: () {
          Get.to(NewOrEditTodoScreen(
            isNew: true,
          ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  _renderList() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: <Widget>[
        TodoCard(() {
          Get.to(NewOrEditTodoScreen(
            isNew: false,
          ));
        })
      ],
    );
  }
}
