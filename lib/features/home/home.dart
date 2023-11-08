import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/shared-widgets/custom_button.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/styles.dart';
import 'package:taskati/features/add-task/addtask.dart';
import 'package:taskati/features/home/widgets/empty_task_widget.dart';
import 'package:taskati/features/home/widgets/home_header.dart';
import 'package:taskati/features/home/widgets/tasks_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DateTime _selectedValue = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.MMMMEEEEd().format(DateTime.now()),
                          style: getTitleStyle(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor)),
                      Text(
                        'Today',
                        style: getTitleStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    text: '+ add Task',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddTaskView(),
                      ));
                    },
                  ),
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: _selectedValue,
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                dateTextStyle: const TextStyle()
                    .copyWith(color: Theme.of(context).primaryColor),
                monthTextStyle: const TextStyle()
                    .copyWith(color: Theme.of(context).primaryColor),
                dayTextStyle: const TextStyle()
                    .copyWith(color: Theme.of(context).primaryColor),
                onDateChange: (date) {
                  setState(() {
                    _selectedValue = date;
                  });
                },
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                valueListenable: Hive.box<Task>('task').listenable(),
                builder:
                    (BuildContext context, Box<Task> value, Widget? child) {
                  List<Task> tasks = value.values.where((element) {
                    if (element.date.split('T').first ==
                        _selectedValue.toIso8601String().split('T').first) {
                      return true;
                    } else {
                      return false;
                    }
                  }).toList();

                  if (value.isEmpty) {
                    return const EmptyTaskWidget();
                  } else {
                    return TaskListWidget(tasks: tasks, value: value);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
