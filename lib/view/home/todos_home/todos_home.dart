import 'package:flutter/material.dart';

import 'components/add_note_field.dart';
import 'components/tasks_list_widget.dart';

class TodosHome extends StatelessWidget {
  const TodosHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _TodoAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            AddNoteField(),
            SizedBox(height: 10),
            TasksListWidget(),
          ],
        ),
      ),
    );
  }
}

class _TodoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const _TodoAppbar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("TODO APP"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
