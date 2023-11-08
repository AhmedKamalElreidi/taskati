// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/styles.dart';
import 'package:taskati/features/home/widgets/task_item.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({
    Key? key,
    required this.value,
    required this.tasks,
  }) : super(key: key);
  final Box<Task> value;
  final List<Task> tasks;

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          Task item = widget.tasks[index];
          return Dismissible(
            key: UniqueKey(),
            secondaryBackground: Container(
              color: AppColors.redColor,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.delete_forever_rounded,
                      color: AppColors.lightBg,
                    ),
                    Text(
                      'Delete Task',
                      style: getSmallTextStyle(color: AppColors.lightBg),
                    )
                  ],
                ),
              ),
            ),
            background: Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(Icons.check, color: AppColors.lightBg),
                    Text(
                      'Complete Task',
                      style: getSmallTextStyle(color: AppColors.lightBg),
                    )
                  ],
                ),
              ),
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                setState(() {
                  widget.value.put(
                      '${item.title}-${item.date}',
                      Task(
                          id: '${item.title}-${item.date}',
                          title: item.title,
                          note: item.note,
                          date: item.date,
                          startTime: item.startTime,
                          endTime: item.endTime,
                          color: 3,
                          isComplete: true));
                });
              } else {
                setState(() {
                  widget.value.delete(
                    '${item.title}-${item.date}',
                  );
                });
              }
            },
            child: TaskItem(
              task: item,
            ),
          );
        },
      ),
    );
  }
}
