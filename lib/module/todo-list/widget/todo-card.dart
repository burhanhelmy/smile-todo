import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:smile_todo/module/todo-list/bloc/list.dart';
import 'package:smile_todo/module/todo-list/bloc/mutate.dart';

class TodoCard extends StatefulWidget {
  final Function onPressed;
  final TodoModel todo;

  TodoCard(this.todo, this.onPressed);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  TodoMutateBloc _todoMutateBloc;

  @override
  Widget build(BuildContext context) {
    print(DateTime.parse(widget.todo.startDate).millisecond -
        DateTime.parse(widget.todo.estEndDate).millisecond);

    _todoMutateBloc = TodoMutateBloc();

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
            onTap: widget.onPressed,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.todo.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _renderLabelAndValue(
                              "Start Date",
                              DateFormat.yMMMd().format(
                                  DateTime.parse(widget.todo.startDate))),
                          _renderLabelAndValue(
                              "End Date",
                              DateFormat.yMMMd().format(
                                  DateTime.parse(widget.todo.estEndDate))),
                          _renderLabelAndValue("Time Left", _formatTime())
                        ]),
                  )
                ],
              ),
            ),
          ),
          BlocProvider(
            create: (BuildContext context) {
              return _todoMutateBloc;
            },
            child: Container(
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
                            "Status: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            widget.todo.done ? "Complete" : "Incomplete",
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
                        BlocBuilder<TodoMutateBloc, TodoMutateState>(
                          builder:
                              (BuildContext context, TodoMutateState state) {
                            return Checkbox(
                                value: widget.todo.done,
                                onChanged: (checked) {
                                  widget.todo.done = checked;
                                  context
                                      .bloc<TodoMutateBloc>()
                                      .add(CompletePressed(todo: widget.todo));
                                  setState(() {});
                                });
                          },
                        ),
                      ],
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  _formatTime() {
    var remaining = DateTime.parse(widget.todo.estEndDate)
        .difference(DateTime.parse(widget.todo.startDate));

    if (remaining.inDays != 0) {
      return '${remaining.inDays} days';
    }
    if (remaining.inHours != 0) {
      return '${remaining.inHours} hrs';
    }
    if (remaining.inMinutes != 0) {
      return '${remaining.inHours}';
    }
    if (remaining.inSeconds != 0) {
      return '${remaining.inSeconds} sec';
    } else {
      return "End";
    }
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
