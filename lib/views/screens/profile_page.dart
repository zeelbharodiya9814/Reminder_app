import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pr_reminder_app/modals/reminder.dart';
import 'package:provider/provider.dart';

import '../../controller/reminder_controller.dart';
import '../../controller/theme_controller.dart';
import '../../helpers/db_helper.dart';
import '../../helpers/notification_helper.dart';
import 'edit_reminder.dart';
import 'global.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  String? date;
  String? note;

  String? title;
  TextEditingController titleController = TextEditingController();
  TextEditingController discController = TextEditingController();

  static String? dd;

  TextEditingController ddController = TextEditingController(text: dd);

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

  GlobalKey<FormState> updateformKey = GlobalKey<FormState>();

  DateTime ddd = DateTime.now();

  late Future getAllData;

  void initState() {
    super.initState();
    getAllData = DBHelper.dbHelper.initDB();
    getAllData = DBHelper.dbHelper.fetchAllRecords();
    // NotificationHelper.notificationHelper.scheduleNotification()
    NotificationHelper.notificationHelper.NotificationInitialize();
    String dd = ddd.toString();
    print(dd);
    DateTime? ds = DateTime.tryParse(dd);
    print(ds);
    print(ds!.hour);
    print(ds.microsecond);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Container(),
        title: Text(
          "Reminders",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            // color: Colors.black,
            fontFamily: GoogleFonts.kanit().fontFamily,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changetheme();
              GLOBAL.bootom = false;
            },
            icon: Provider.of<ThemeProvider>(context).tm1.isDark
                ? Icon(
              Icons.light_mode_outlined,
              color: Colors.white,
            )
                : Icon(
              Icons.dark_mode,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: FutureBuilder(
        future: getAllData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            List data = snapshot.data;

            return (data != null)
                ? (data.isEmpty) 
                   ? Container(
                     child: Center(
                        child:  Padding(
                          padding: const EdgeInsets.only(bottom: 80.0),
                          child: Image.asset("assets/images/no-data.png",height: 130,width: 130,),
                        ),
                      ),
                   )
                   : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {

                      DateTime t = DateTime.parse(data[i].hour);

                      NotificationHelper.notificationHelper.showNotification(
                        id: data[i].id,
                        title: data[i].title,
                        description: data[i].description,
                        scheduleTime: data[i].hour,
                      );

                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: Card(
                          elevation: 5,
                          color: Provider.of<ThemeProvider>(context).tm1.isDark
                              ? Colors.grey[800]
                              : Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${data[i].title}",
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green,
                                          fontFamily:
                                          GoogleFonts.abel().fontFamily,
                                          letterSpacing: 2,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 10, right: 10),
                                child: Divider(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Description : ${data[i].description}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        // color: Colors.black,
                                        fontFamily:
                                        GoogleFonts.kanit().fontFamily,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, bottom: 10),
                                child: Row(
                                  children: [

                                    (t.hour > 12)
                                        ? Text(
                                      '${t.hour - 12} :${t.minute} PM',
                                      style:  TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: GoogleFonts.abel().fontFamily,
                                        letterSpacing: 2,
                                      ),
                                    )
                                        : Text(
                                      '${t.hour} :${t.minute} AM',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        // color: Colors.black,
                                        fontFamily:
                                        GoogleFonts.abel().fontFamily,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    // Text("Time : ${data[i].hour} : ${data[i].minute}",style: Text'Style(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: GoogleFonts.kanit().fontFamily,letterSpacing: 2,),),
                                    Spacer(),
                                    Text("${data[i].id}",style: TextStyle(color: Colors.transparent),),
                                    IconButton(
                                        onPressed: () {
                                          titleController.text = data[i].title;
                                          discController.text = data[i].description;
                                          DateTime updateTime = DateTime.parse(data[i].hour);

                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (all) => StatefulBuilder(
                                                builder: (context, setState) {
                                                  return AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    content: Form(
                                                      key: updateformKey,
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        children: [
                                                          SizedBox(height: 15,),
                                                          Card(
                                                            elevation: 5,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20)),
                                                            child: TextFormField(
                                                              controller:
                                                              titleController,
                                                              textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                              validator: (val) {
                                                                if (val!.isEmpty) {
                                                                  return "Enter title...";
                                                                }
                                                              },
                                                              onSaved: (val) {
                                                                setState(() {
                                                                  title = val;
                                                                });
                                                                print(title);
                                                              },
                                                              decoration:
                                                              InputDecoration(
                                                                  // filled: true,
                                                                  // fillColor:
                                                                  // Colors
                                                                  //     .white,
                                                                  border:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        20),
                                                                    borderSide:
                                                                    BorderSide
                                                                        .none,
                                                                  )),
                                                            ),
                                                          ),
                                                          Card(
                                                            elevation: 5,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20)),
                                                            child: TextFormField(
                                                              controller:
                                                              discController,
                                                              textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                              validator: (val) {
                                                                if (val!.isEmpty) {
                                                                  return "Enter rem...";
                                                                }
                                                              },
                                                              onSaved: (val) {
                                                                setState(() {
                                                                  note = val;
                                                                });
                                                                print(note);
                                                              },
                                                              decoration:
                                                              InputDecoration(
                                                                  // filled: true,
                                                                  // fillColor:
                                                                  // Colors
                                                                  //     .white,
                                                                  border:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        20),
                                                                    borderSide:
                                                                    BorderSide
                                                                        .none,
                                                                  )),
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  DatePicker.showDateTimePicker(
                                                                    context,
                                                                    showTitleActions: true,
                                                                    currentTime: updateTime,
                                                                    onChanged: (date) {
                                                                      setState(() {
                                                                        updateTime = date;
                                                                      });
                                                                    },
                                                                    onConfirm: (date) {},
                                                                  );
                                                                  // dateTimePicker(context, reminderController);
                                                                },
                                                                icon: Icon(Icons.watch_later_outlined,color: Colors.blue,),
                                                              ),
                                                              (updateTime.hour < 12)
                                                                  ? Text(
                                                                '${updateTime.hour} : ${updateTime.minute} AM',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  // color: Colors.grey.shade400,
                                                                  fontSize: 20,
                                                                ),
                                                              )
                                                                  : Text(
                                                                '${updateTime.hour - 12}:${updateTime.minute} PM',
                                                                style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.grey.shade400,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          OutlinedButton(
                                                              onPressed: () {
                                                                // reminderController.clearDateTime();
                                                                titleController.clear();
                                                                discController.clear();

                                                                setState(() {
                                                                  title = null;
                                                                  note = null;
                                                                });

                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                              Text("Cancel")),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          ElevatedButton(
                                                              onPressed: () async {
                                                                if (updateformKey.currentState!.validate()) {
                                                                  updateformKey.currentState!.save();


                                                                  var allId = data[i].id;

                                                                  ReminderDB reminderDB = ReminderDB(
                                                                    id: allId,
                                                                    title: title!,
                                                                    description: note!,
                                                                    hour: updateTime.toString(),
                                                                    // minute: reminderController.minute.value
                                                                  );

                                                                  // Reminder reminder2 = Reminder(
                                                                  // title: title!,
                                                                  // description: note!,
                                                                  // hour: reminderController.hour.value,
                                                                  // minute: reminderController.minute.value);

                                                                  // NotificationHelper.notificationHelper
                                                                  //     .scheduleNotification(reminder: reminderDB);
                                                                  DBHelper.dbHelper.updateReminder(reminder: reminderDB);

                                                                  // reminderController.clearDateTime();

                                                                  Navigator.pop(context);
                                                                  setState(() {

                                                                  });
                                                                  // Navigator.pushNamed(context, 'ReminderPage');

                                                                } else {
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      content: Text("Record insertion failed"),
                                                                      backgroundColor: Colors.red,
                                                                      behavior: SnackBarBehavior.floating,
                                                                    ),
                                                                  );
                                                                }
                                                                // reminderController.clearDateTime();
                                                                // titleController.clear();
                                                                // discController.clear();
                                                                //
                                                                // setState(() {
                                                                //   title = null;
                                                                //   note = null;
                                                                // });
                                                              },
                                                              child:
                                                              Text("Edit")),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                }
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        )),
                                    SizedBox(width: 4,),
                                    IconButton(
                                        onPressed: () async {
                                          await DBHelper.dbHelper
                                              .deleteReminder(id: data[i].id);


                                          setState(() {
                                            getAllData = DBHelper
                                                .dbHelper
                                                .fetchAllRecords();
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.blue,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Text("No data available..."),
                  );
          }
          return Center(
            child: CircularProgressIndicator(
              value: 0.8,
            ),
          );
        },
      ),
    );
  }
}
