// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/styles.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  Color getColor(int index) {
    switch (index) {
      case 0:
        return AppColors.primaryColor;
      case 1:
        return AppColors.orangeColor;
      case 2:
        return AppColors.redColor;
      case 3:
        return Colors.green;
      default:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: getColor(task.color)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: getTitleStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(children: [
                const Icon(
                  Icons.watch_later_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 5),
                Text(
                  '${task.startTime}: ${task.endTime}',
                  style: getSmallTextStyle(color: AppColors.lightBg),
                )
              ]),
              const SizedBox(height: 10),
              Text(
                task.note,
                style: getSubTitleStyle(color: Colors.white),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: .5,
            color: Colors.white,
            height: 80,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isComplete ? 'COMPLETED' : 'TODO',
              style: getSubTitleStyle(color: AppColors.lightBg),
            ),
          )
        ],
      ),
    );
  }
}
