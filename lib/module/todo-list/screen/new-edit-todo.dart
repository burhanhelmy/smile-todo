import 'package:flutter/material.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:smile_todo/module/todo-list/styles.dart';

class NewOrEditTodoScreen extends StatefulWidget {
  final bool isNew;
  final TodoModel todo;
  NewOrEditTodoScreen({this.isNew, this.todo});

  @override
  _NewOrEditTodoScreenState createState() => _NewOrEditTodoScreenState();
}

class _NewOrEditTodoScreenState extends State<NewOrEditTodoScreen> {
  var todoStyles = TodoListStyles();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.isNew ? "Add new" : "Edit"} To-Do",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: _renderBody());
  }

  _renderBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ListView(
              children: <Widget>[
                todoStyles.widgetSpacing(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _renderLabel(
                        "To-Do Title",
                      ),
                      TextField(
                          maxLines: 5, decoration: todoStyles.inputDecoration)
                    ],
                  ),
                ),
                todoStyles.widgetSpacing(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _renderLabel(
                        "Start Date",
                      ),
                      TextField(
                        decoration: todoStyles.inputDecorationDate,
                        readOnly: true,
                      )
                    ],
                  ),
                ),
                todoStyles.widgetSpacing(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _renderLabel(
                        "Estimate End Date",
                      ),
                      TextField(
                        decoration: todoStyles.inputDecorationDate,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        RaisedButton(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              widget.isNew ? "Create now" : "Delete",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          onPressed: () {},
          color: widget.isNew ? Colors.black : Colors.red,
        )
      ],
    );
  }

  _renderLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
