import 'package:flutter/material.dart';

class Content {
  final String title;
  final Color color;

  Content(this.title, this.color);
}

List<Content> contents = [
  Content('Red', Colors.redAccent),
  Content('Blue', Colors.blueAccent),
  Content('Teal', Colors.teal),
  Content('Orange', Colors.orange),
];
