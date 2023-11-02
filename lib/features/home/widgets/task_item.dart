import 'package:flutter/material.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/styles.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryColor),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task - 1',
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
                  '12:00 AM: 12:30 AM',
                  style: getSmallTextStyle(color: AppColors.lightBg),
                )
              ]),
              const SizedBox(height: 10),
              Text(
                'note ',
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
              'TODO',
              style: getSubTitleStyle(color: AppColors.lightBg),
            ),
          )
        ],
      ),
    );
  }
}
