import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/context_extensions.dart';
import 'package:todo_app/providers/provider_data.dart';
import 'package:todo_app/view/home/todos_home/models/task_model.dart';

var roundedRectangleBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

class TasksListWidget extends StatelessWidget {
  const TasksListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProviderData>(builder: (context, data, _) {
        return ReorderableListView.builder(
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) newIndex--;
            final TaskModel taskModel = data.tasks.removeAt(oldIndex);
            data.tasks.insert(newIndex,taskModel);
          },
          itemCount: data.tasks.length,
          itemBuilder: (context, index) {
            TaskModel task = data.tasks[index];
            return Padding(
              key: ValueKey(task.id ?? "index"),
              padding: const EdgeInsets.all(8.0),
              child: Dismissible(
                key: ValueKey(task.id ?? ""),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.endToStart) {
                    data.removeTask(task);
                  }

                  return;
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: roundedRectangleBorder.borderRadius,
                  ),
                ),
                onDismissed: (direction) {},
                child: CheckboxListTile(
                  checkboxShape: const CircleBorder(),
                  value: task.isFinished,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    task.changeFinishedState();
                    data.updateTaskLocation(task);
                  },
                  tileColor: Colors.black,
                  shape: roundedRectangleBorder,
                  title: Text(
                    task.taskName,
                    style: context.textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      decoration: task.isFinished ? TextDecoration.lineThrough : TextDecoration.none,
                      decorationThickness: 3.2,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
