import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/reminder_controller.dart';
import '../../controller/theme_controller.dart';
import '../../helpers/db_helper.dart';
import '../../helpers/notification_helper.dart';
import '../../modals/reminder.dart';
import 'global.dart';

class addReminder extends StatefulWidget {
  const addReminder({Key? key}) : super(key: key);

  @override
  State<addReminder> createState() => _addReminderState();
}

class _addReminderState extends State<addReminder> {


  static String? dd;

  TextEditingController ddController = TextEditingController(text: dd);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _gelDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2050))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        ddController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    });
  }

  String? date;
  String? note;

  String? title;
  TextEditingController titleController = TextEditingController();
  TextEditingController discController = TextEditingController();
  // ReminderController reminderController = Get.put(ReminderController());

  // ThemeController themeController = Get.put(ThemeController());

  // TimeOfDay currentTime = TimeOfDay.now();

  DateTime currentTime = DateTime.now();

  // dateTimePicker(context, reminderController) {
  //   showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   ).then((TimeOfDay? value1) {
  //     if (value1 != null) {
  //       reminderController.setDateTime(
  //         hourVal: value1.hour,
  //         minuteVal: value1.minute,
  //         // periodVal: value1.period.name,
  //       );
  //     }
  //   });
  // }

  // TimeOfDay? pickedTime = await showTimePicker(
  // context: context,
  // initialTime: currentTime,
  // builder: (context, widget) {
  // return MediaQuery(
  // data: MediaQuery.of(context).copyWith(
  // alwaysUse24HourFormat: false),
  // child: widget!,
  // );
  // }
  //
  // );
  // setState(() {
  // if (pickedTime != null) {
  // currentTime = pickedTime;
  // }
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Provider.of<ThemeProvider>(context).tm1.isDark
          ? Colors.grey[900]
          : Colors.grey[200],
      appBar: AppBar(
        // backgroundColor: Provider.of<ThemeProvider>(context).tm1.isDark
        //     ? Colors.grey[800]
        //     : Colors.grey[200],
        // centerTitle: true,
        // leading: ,
        title: Text(
          "Add New Reminder",
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Provider.of<ThemeProvider>(context).tm1.isDark
                ? Colors.white
                : Colors.black,
            fontFamily: GoogleFonts.kanit().fontFamily,
            letterSpacing: 2,
          ),
        ),

        actions: [
          IconButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                    ReminderDB reminder = ReminderDB(
                        title: title!,
                        description: note!,
                        hour: currentTime.toString(),
                        date: date.toString(),
                        // minute: reminderController.minute.value
                    );

                    // NotificationHelper.notificationHelper
                    //     .scheduleNotification(reminder: reminder);

                    DBHelper.dbHelper.insertRecord(reminder: reminder);

                    // reminderController.clearDateTime();
                  Navigator.pushNamed(context, 'Profile');
                   setState(() {

                   });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Record insertion failed"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
                titleController.clear();
                discController.clear();
                ddController.clear();

                setState(() {
                  title = null;
                  date = null;
                  note = null;
                });
              },
              icon: Icon(
                Icons.done_outline_rounded,
                color: Colors.green,
              )),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12),
                child: Row(
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        // color: Colors.black,
                        fontFamily: GoogleFonts.kanit().fontFamily,
                        letterSpacing: 2,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 3, right: 12),
                child: Container(
                  // height: 100,
                  // width: double.infinity,
                  margin: EdgeInsets.only(top: 4, bottom: 10),
                  alignment: Alignment.center,
                  child: Center(
                    child: TextFormField(
                      controller: titleController,
                      onChanged: (val) {
                        setState(() {
                          title = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter title...";
                        }
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        // hintText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        offset: Offset(-3.0, -3.0),
                        blurRadius: 8.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                      ),
                    ],
                    color: Provider.of<ThemeProvider>(context).tm1.isDark
                        ? Colors.grey[900]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12),
                child: Row(
                  children: [
                    Text(
                      "Discription",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        // color: Colors.black,
                        fontFamily: GoogleFonts.kanit().fontFamily,
                        letterSpacing: 2,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 3, right: 12),
                child: Container(
                  // height: 100,
                  // width: double.infinity,
                  margin: EdgeInsets.only(top: 4, bottom: 10),
                  alignment: Alignment.center,
                  child: Center(
                    child: TextFormField(
                      controller: discController,
                      onSaved: (val) {
                        setState(() {
                          note = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter note...";
                        }
                      },
                      style: TextStyle(fontSize: 18),
                      // readOnly: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        offset: Offset(-3.0, -3.0),
                        blurRadius: 8.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                      ),
                    ],
                    color: Provider.of<ThemeProvider>(context).tm1.isDark
                        ? Colors.grey[900]
                        : Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12),
                child: Row(
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        // color: Colors.black,
                        fontFamily: GoogleFonts.kanit().fontFamily,
                        letterSpacing: 2,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 3, right: 12),
                child: GestureDetector(
                  onTap: () async {},
                  child: Container(
                    // height: 100,
                    // width: double.infinity,
                    margin: EdgeInsets.only(top: 4, bottom: 10),
                    alignment: Alignment.center,
                    child: Center(
                      child: TextFormField(
                        onTap: _gelDatePicker,
                        onSaved: (_gelDatePicker) {
                          setState(() {
                            date = _gelDatePicker;
                            print(date);
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter date...";
                          }
                        },
                        controller: ddController,
                        style: TextStyle(fontSize: 18),
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          // hintText: "DD/MM/YYYY",
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          offset: Offset(-3.0, -3.0),
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(3.0, 3.0),
                          blurRadius: 8.0,
                        ),
                      ],
                      color: Provider.of<ThemeProvider>(context).tm1.isDark
                          ? Colors.grey[900]
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12),
                child: Row(
                  children: [
                    Text(
                      "Time",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        // color: Colors.black,
                        fontFamily: GoogleFonts.kanit().fontFamily,
                        letterSpacing: 2,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 3, right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() async {
                      // dateTimePicker(context, reminderController);
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onChanged: (date) {
                            setState(() {
                              currentTime = date;
                            });
                          },
                          onConfirm: (date) {});
                    });
                  },
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.only(top: 4, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        (currentTime.hour < 12)
                            ? Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                          '${currentTime.hour}:${currentTime.minute} AM',
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.grey.shade400,
                              fontSize: 20,
                          ),
                        ),
                            )
                            : Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Text(
                          '${currentTime.hour - 12}:${currentTime.minute} PM',
                          style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              // color: Colors.grey.shade800,
                              fontSize: 18,
                          ),
                        ),
                            ),

                        // (reminderController.hour.value != 0)
                        //     ? Padding(
                        //       padding: const EdgeInsets.all(13.0),
                        //       child: Text(
                        //   "${(reminderController.hour.value > 12) ? reminderController.hour.value - 12 : reminderController.hour.value}:${reminderController.minute.value} ${(reminderController.hour.value > 12) ? "PM" : "AM"}",
                        // ),
                        //     )
                        //     : const Text(""),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Icon(
                            Icons.more_time,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.1),
                          offset: Offset(-3.0, -3.0),
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(3.0, 3.0),
                          blurRadius: 8.0,
                        ),
                      ],
                      color: Provider.of<ThemeProvider>(context).tm1.isDark
                          ? Colors.grey[900]
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
