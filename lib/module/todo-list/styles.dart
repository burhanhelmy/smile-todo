import 'package:flutter/material.dart';

class TodoListStyles {
  get inputDecoration {
    return InputDecoration(
      hintText: "Please key in your To-Do Title",
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange[800], width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
    );
  }

  get inputDecorationDate {
    return InputDecoration(
        hintText: "Select a date",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange[800], width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        suffixIcon: Icon(Icons.keyboard_arrow_down));
  }

  widgetSpacing(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
