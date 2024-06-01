import 'package:flutter/material.dart';
import 'package:tusk_app/data/models/user.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key, required this.employee});
  final User employee;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
    );
  }
}