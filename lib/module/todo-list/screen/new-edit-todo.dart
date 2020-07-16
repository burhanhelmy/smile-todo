import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smile_todo/module/database/todo_provider.dart';
import 'package:smile_todo/module/todo-list/bloc/mutate.dart';
import 'package:smile_todo/module/todo-list/styles.dart';

class NewOrEditTodoScreen extends StatefulWidget {
  final bool isNew;
  final TodoModel todo;
  NewOrEditTodoScreen({this.isNew, this.todo});

  @override
  _NewOrEditTodoScreenState createState() => _NewOrEditTodoScreenState();
}

class _NewOrEditTodoScreenState extends State<NewOrEditTodoScreen> {
  TodoMutateBloc _todoMutateBloc;
  DateTime startDate = DateTime.now();
  DateTime estEndDate = DateTime.now();
  String title;

  @override
  void initState() {
    if (!widget.isNew) {
      startDate = DateTime.parse(widget?.todo?.startDate);
      estEndDate = DateTime.parse(widget?.todo?.estEndDate);
      title = widget?.todo?.title;
    }
    _todoMutateBloc = TodoMutateBloc();
    super.initState();
  }

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
          actions: <Widget>[
            !widget.isNew
                ? IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      // _todoMutateBloc = TodoMutateBloc();
                      _todoMutateBloc.add(DeletePressed(todo: widget.todo));
                      Get.back();
                    })
                : Container()
          ],
        ),
        body: _renderBody());
  }

  _renderBody() {
    return BlocProvider(
      create: (BuildContext context) {
        return _todoMutateBloc;
      },
      child: Column(
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
                            controller: TextEditingController(text: title),
                            onChanged: (text) {
                              setState(() {
                                title = text;
                              });
                            },
                            maxLines: 5,
                            decoration: todoStyles.inputDecoration)
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
                          controller: TextEditingController(
                              text: DateFormat.yMMMd().format(startDate)),
                          onTap: () async {
                            var dateTime = await _getDate();
                            if (dateTime != null) {
                              setState(() {
                                startDate = dateTime;
                              });
                            }
                          },
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
                          "Estimate End Date ",
                        ),
                        TextField(
                          controller: TextEditingController(
                              text: DateFormat.yMMMd().format(estEndDate)),
                          onTap: () async {
                            var dateTime = await _getDate();
                            if (dateTime != null) {
                              setState(() {
                                estEndDate = dateTime;
                              });
                            }
                          },
                          decoration: todoStyles.inputDecorationDate,
                          readOnly: true,
                        ),
                        estEndDate.difference(startDate).isNegative
                            ? Text(
                                "*Must be greter than start",
                                style: TextStyle(color: Colors.red),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocListener(
            bloc: _todoMutateBloc,
            listener: (context, state) {
              if (state is AddSucess) {
                Get.back();
              }
              if (state is TodoUpdated) {
                Get.snackbar(title, "Updated and saved.",
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 5));
              }
            },
            child: BlocBuilder<TodoMutateBloc, TodoMutateState>(
                builder: (context, todoList) {
              return RaisedButton(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    widget.isNew ? "Create now" : "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                onPressed: _disableSaveBtn
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        if (widget.isNew) {
                          context.bloc<TodoMutateBloc>().add(AddPressed(
                              todo: TodoModel(
                                  title: title,
                                  startDate: startDate.toIso8601String(),
                                  estEndDate: estEndDate.toIso8601String(),
                                  done: false)));
                        } else {
                          context.bloc<TodoMutateBloc>().add(SavePressed(
                              todo: TodoModel(
                                  id: widget.todo.id,
                                  title: title,
                                  startDate: startDate.toIso8601String(),
                                  estEndDate: estEndDate.toIso8601String(),
                                  done: widget.todo.done)));
                        }
                      },
                color: Colors.black,
              );
            }),
          )
        ],
      ),
    );
  }

  get _disableSaveBtn {
    return (title == null ||
        title == "" ||
        startDate == null ||
        estEndDate == null ||
        estEndDate.difference(startDate).isNegative);
  }

  Future<DateTime> _getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      builder: (BuildContext context, Widget child) {
        return Theme(
          isMaterialAppTheme: true,
          data: Theme.of(context),
          child: child,
        );
      },
      lastDate: DateTime(2050),
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
