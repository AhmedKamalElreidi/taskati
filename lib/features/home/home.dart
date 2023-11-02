import 'dart:io';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/local_data.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/features/add-task/addtask.dart';
import 'package:taskati/features/home/widgets/task_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: AppLocal.getChached(AppLocal.nameKey),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              'Hello , ${snapshot.data!.split(' ').first}',
                              style: getHeadlineStyle(),
                            );
                          } else {
                            return Text(
                              'Hello ,',
                              style: getHeadlineStyle(),
                            );
                          }
                        },
                      ),
                      Text(
                        'Have A Nice Day',
                        style: getSmallTextStyle(),
                      ),
                    ],
                  ),
                  // const Spacer(),
                  FutureBuilder(
                    future: AppLocal.getChached(AppLocal.imageKey),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 26,
                          backgroundColor: AppColors.primaryColor,
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: FileImage(File(snapshot.data!)),
                          ),
                        );
                      } else {
                        return const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            backgroundImage: AssetImage("assets/user.png"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.MMMMEEEEd().format(DateTime.now()),
                        style: getTitleStyle()),
                    Text(
                      'Today',
                      style: getTitleStyle(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddTask(),
                    ));
                  },
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor),
                    child: Text(
                      '+ add Task',
                      style: getSmallTextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    // _selectedValue = date;
                  });
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const TaskItem();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
