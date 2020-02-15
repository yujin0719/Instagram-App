import 'package:flutter/material.dart';

// snakbar는 scaffold 내의 context를 사용해야 한다.
void simpleSnackbar(BuildContext context, String txt) {
  final snackBar = SnackBar(content: Text(txt));
  Scaffold.of(context).showSnackBar(snackBar);
}