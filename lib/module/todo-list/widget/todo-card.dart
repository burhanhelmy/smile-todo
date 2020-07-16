import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:smile_todo/module/todo-list/bloc/list.dart';

class TodoCard extends StatelessWidget {
  final Function onPressed;
  final TodoModel todo;

  TodoCard(this.todo, this.onPressed);
  @override
  Widget build(BuildContext context) {
    print(todo.done);
    print(todo.estEndDate);
    print(todo.startDate);
    print(todo.title);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Automated Testing Script",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _renderLabelAndValue("Start Date", "todo.startDate"),
                          _renderLabelAndValue("End Date", "todo.estEndDate"),
                          _renderLabelAndValue("Time Left", "time left")
                        ]),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: BlocBuilder<TodoListBloc, List<TodoModel>>(
                builder: (context, todoList) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Status:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        Text(
                          "Incomplete",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Tick if complete",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Checkbox(value: false, onChanged: null),
                    ],
                  )
                ],
              );
            }),
          )
        ],
      ),
    );
  }

  _renderLabelAndValue(label, value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
