// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/custom_button.dart';
import 'package:taskati/core/styles.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // variables of controller
  var titleCon = TextEditingController();
  var noteCon = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // ------------- initial Date, Start Time and End Time ------------
  DateTime _date = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  late int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- title ----------------
              Text(
                'Title',
                style: getSubTitleStyle(),
              ),
              TextFormField(
                controller: titleCon,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title mustn\'t be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter a Title here',
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              // ---------- note ----------------
              Text(
                'Note',
                style: getSubTitleStyle(),
              ),
              TextFormField(
                controller: noteCon,
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Note mustn\'t be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter a Note here',
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              // ---------- Date ----------------
              Text(
                'Date',
                style: getSubTitleStyle(),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Note mustn\'t be empty';
                  }
                  return null;
                },
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final datePicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData(
                                dialogBackgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                datePickerTheme: DatePickerThemeData(
                                    headerForegroundColor: Colors.white,
                                    yearForegroundColor:
                                        MaterialStatePropertyAll(
                                            Theme.of(context).primaryColor)),
                                colorScheme: ColorScheme.light(
                                  primary: AppColors
                                      .primaryColor, // header background color
                                  onPrimary: Theme.of(context)
                                      .primaryColorLight, // header text color
                                  onSurface: Theme.of(context)
                                      .primaryColor, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors
                                        .primaryColor, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        //هنا انا عملت متغير وقولتلو هات الوقت اللى هتختارو وساوية بامتغير ديت بيكد وبعد كدا عملت سيت استيت وساوتها بالوقت الموجود فوق
                        if (datePicked != null) {
                          setState(() {
                            _date = datePicked;
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_month)),
                  hintText: DateFormat.yMd().format(_date),
                ),
              ),
              const SizedBox(height: 5),

              // ---------- Start & End Time  ----------------
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Start Time',
                    style: getSubTitleStyle(),
                  )),
                  Expanded(
                      child: Text(
                    'End Time',
                    style: getSubTitleStyle(),
                  )),
                ],
              ),
              Row(
                children: [
                  // ---------- Start Time ----------------
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Note mustn\'t be empty';
                        }
                        return null;
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final datePicked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                        timePickerTheme: TimePickerThemeData(
                                            helpTextStyle: TextStyle(
                                                color: AppColors.primaryColor),
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        colorScheme: ColorScheme.light(
                                          background: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          primary: AppColors
                                              .primaryColor, // header background color
                                          secondary:
                                              Theme.of(context).primaryColor,
                                          onSecondary:
                                              Theme.of(context).primaryColor,
                                          onPrimary: Theme.of(context)
                                              .primaryColor, // header text color
                                          onSurface: Theme.of(context)
                                              .primaryColor, // body text color
                                          surface: Theme.of(context)
                                              .primaryColor, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors
                                                .primaryColor, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              if (datePicked != null) {
                                setState(() {
                                  _startTime = datePicked.format(context);
                                  int plus15Min = datePicked.minute + 15;
                                  _endTime = datePicked
                                      .replacing(minute: plus15Min)
                                      .format(context);
                                });
                              }
                            },
                            icon: const Icon(Icons.watch_later_outlined)),
                        hintText: _startTime,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),

                  // ---------- End Time ----------------
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Note mustn\'t be empty';
                        }
                        return null;
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final datePicked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                        timePickerTheme: TimePickerThemeData(
                                            helpTextStyle: TextStyle(
                                                color: AppColors.primaryColor),
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        colorScheme: ColorScheme.light(
                                          background: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          primary: AppColors
                                              .primaryColor, // header background color
                                          secondary:
                                              Theme.of(context).primaryColor,
                                          onSecondary:
                                              Theme.of(context).primaryColor,
                                          onPrimary: Theme.of(context)
                                              .primaryColor, // header text color
                                          onSurface: Theme.of(context)
                                              .primaryColor, // body text color
                                          surface: Theme.of(context)
                                              .primaryColor, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors
                                                .primaryColor, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              if (datePicked != null) {
                                setState(() {
                                  _endTime = datePicked.format(context);
                                });
                              }
                            },
                            icon: const Icon(Icons.watch_later_outlined)),
                        hintText: _endTime,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  // ---------- Choose a Color ----------------
                  Row(
                    children: [
                      ColorItem(0, AppColors.primaryColor),
                      const SizedBox(
                        width: 5,
                      ),
                      ColorItem(1, AppColors.orangeColor),
                      const SizedBox(
                        width: 5,
                      ),
                      ColorItem(2, AppColors.redColor)
                    ],
                  ),
                  const Spacer(),

                  CustomButton(
                    text: 'Create Task',
                    onTap: () async {
                      // if (_formKey.currentState!.validate()) {
                      //   await box.put(
                      //       '${titleCon.text}-${_date.toIso8601String()}',
                      //       Task(
                      //           id: '${titleCon.text} ${_date.toIso8601String()}',
                      //           title: titleCon.text,
                      //           note: noteCon.text,
                      //           date: _date.toIso8601String(),
                      //           startTime: _startTime,
                      //           endTime: _endTime,
                      //           color: _selectedColor,
                      //           isComplete: false));
                      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => const HomeView(),
                      //   ));
                      // }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ColorItem(int index, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = index;
        });
      },
      child: CircleAvatar(
        backgroundColor: color,
        radius: 20,
        child: (_selectedColor == index)
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
