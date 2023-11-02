import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/core/colors.dart';
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
  late DateTime _date;
  String? _startTime;
  String? _endTime;

  // int _selectedColor = 0;
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
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final datePicked = await showDatePicker(
                          currentDate: DateTime.now(),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2050),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors
                                      .primaryColor, // header background color
                                  onPrimary: Colors.white, // header text color
                                  onSurface:
                                      AppColors.primaryColor, // body text color
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
                        if (datePicked != null) {
                          setState(() {
                            _date = datePicked;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.calendar_month,
                        color: AppColors.primaryColor,
                      )),
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
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors
                                            .primaryColor, // header background color
                                        onPrimary:
                                            Colors.black, // header text color
                                        onSurface: AppColors
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

                              // if (datePicked != null) {
                              //   setState(() {
                              //     _startTime = datePicked.format(context);
                              //     int plus15Min = datePicked.minute + 15;
                              //     _endTime = datePicked
                              //         .replacing(minute: plus15Min)
                              //         .format(context);
                              //   });
                              // }
                            },
                            icon: Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.primaryColor,
                            )),
                        //hintText: _startTime,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),

                  // ---------- End Time ----------------
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              final timePicker = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    DateTime.now()
                                        .add(const Duration(minutes: 15))),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData(
                                      colorScheme: ColorScheme.light(
                                        primary: AppColors
                                            .primaryColor, // header background color
                                        onPrimary:
                                            Colors.black, // header text color
                                        onSurface: AppColors
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

                              if (timePicker != null) {
                                setState(() {
                                  _endTime = timePicker.format(context);
                                });
                              }
                            },
                            icon: Icon(
                              Icons.watch_later_outlined,
                              color: AppColors.primaryColor,
                            )),
                        hintText: _endTime,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  // ---------- Choose a Color ----------------
                  Row(
                    children: [
                      GestureDetector(
                          // onTap: () {
                          //   setState(() {
                          //     _selectedColor = 0;
                          //   });
                          // },
                          // child: CircleAvatar(
                          //   backgroundColor: AppColors.primaryColor,
                          //   radius: 20,
                          //   child: (_selectedColor == 0)
                          //       ? const Icon(
                          //           Icons.check,
                          //           color: Colors.white,
                          //         )
                          //       : null,
                          // ),
                          ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          // onTap: () {
                          //   setState(() {
                          //     _selectedColor = 1;
                          //   });
                          // },
                          // child: CircleAvatar(
                          //   backgroundColor: AppColors.orangeColor,
                          //   radius: 20,
                          //   child: (_selectedColor == 1)
                          //       ? const Icon(
                          //           Icons.check,
                          //           color: Colors.white,
                          //         )
                          //       : null,
                          // ),
                          ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          // onTap: () {
                          //   setState(() {
                          //     _selectedColor = 2;
                          //   });
                          // },
                          // child: CircleAvatar(
                          //   backgroundColor: AppColors.redColor,
                          //   radius: 20,
                          //   child: (_selectedColor == 2)
                          //       ? const Icon(
                          //           Icons.check,
                          //           color: Colors.white,
                          //         )
                          //       : null,
                          // ),
                          )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      child: const Text(
                        'Create Task',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
