import 'package:flutter/material.dart';

ShapeDecoration mainButton() {
  return ShapeDecoration(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xffBE55E9), Color(0xff6449D8)]),
  );
}
