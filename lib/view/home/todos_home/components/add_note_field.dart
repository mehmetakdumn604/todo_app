import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/context_extensions.dart';
import 'package:todo_app/providers/provider_data.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/view/home/todos_home/models/task_model.dart';

class AddNoteField extends StatefulWidget {
  const AddNoteField({
    super.key,
  });

  @override
  State<AddNoteField> createState() => _AddNoteFieldState();
}

class _AddNoteFieldState extends State<AddNoteField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderData>(builder: (context, data, _) {
      return TextFormField(
        controller: _controller,
        onFieldSubmitted: (value) {
          if (value.trim().isEmpty) {
            return;
          }
          TaskModel taskModel = TaskModel(taskName: value, createdDate: DateTime.now().toIso8601String(), lastChangeDate: DateTime.now().toIso8601String());

          data.addTask(taskModel);
          _controller.clear();
        },
        style: context.textTheme.titleMedium!.copyWith(color: Colors.black),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "Add a note...",
            hintStyle: context.textTheme.titleMedium!.copyWith(color: Colors.black.withOpacity(.5)),
            filled: true,
            fillColor: Colors.grey.shade300),
      );
    });
  }
}
