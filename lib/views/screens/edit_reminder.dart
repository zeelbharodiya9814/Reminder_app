// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/reminder_controller.dart';
// import '../../helpers/db_helper.dart';
// import '../../helpers/notification_helper.dart';
// import '../../modals/reminder.dart';
//
//
//
//
// class EditPage extends StatefulWidget {
//   const EditPage({Key? key}) : super(key: key);
//
//   @override
//   State<EditPage> createState() => _EditPageState();
// }
//
// class _EditPageState extends State<EditPage> {
//
//   String? date;
//   String? note;
//
//   String? title;
//   TextEditingController titleController = TextEditingController();
//   TextEditingController discController = TextEditingController();
//
//   GlobalKey<FormState> updateformKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IconButton(
//           onPressed: () {
//             namecontroller.text = data[i].name;
//             agecontroller.text =
//                 data[i].age.toString();
//             coursecontroller.text =
//                 data[i].course;
//             image = data[i].image;
//             showDialog(
//               barrierDismissible: false,
//               context: context,
//               builder: (all) => AlertDialog(
//                 backgroundColor: Colors.white,
//                 content: Form(
//                   key: updateformKey,
//                   child: Column(
//                     mainAxisSize:
//                     MainAxisSize.min,
//                     children: [
//                       Stack(
//                         alignment:
//                         Alignment.center,
//                         children: [
//                           StatefulBuilder(
//                             builder: (context, setState) {
//                               return InkWell(
//                                 onTap: () async {
//                                   XFile? xfile = await pick.pickImage(
//                                       source: ImageSource.camera,
//                                       imageQuality: 50);
//                                   image = await xfile!.readAsBytes();
//                                   setState((){
//
//                                   });
//                                 },
//                                 child: CircleAvatar(
//                                   radius: 40,
//                                   backgroundImage: (image != null)
//                                       ? MemoryImage(image as Uint8List)
//                                       : null,
//                                   backgroundColor: Colors.grey[300],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius
//                                 .circular(
//                                 20)),
//                         child: TextFormField(
//                           controller:
//                           namecontroller,
//                           textInputAction:
//                           TextInputAction
//                               .next,
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return "Enter name...";
//                             }
//                           },
//                           onSaved: (val) {
//                             setState(() {
//                               names = val;
//                             });
//                           },
//                           decoration:
//                           InputDecoration(
//                               prefixIcon:
//                               Icon(
//                                 Icons
//                                     .person,
//                                 color: Colors
//                                     .black,
//                               ),
//                               hintText:
//                               "Name",
//                               hintStyle: TextStyle(
//                                   color: Colors
//                                       .grey[
//                                   400]),
//                               filled: true,
//                               fillColor:
//                               Colors
//                                   .white,
//                               border:
//                               OutlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.circular(
//                                     20),
//                                 borderSide:
//                                 BorderSide
//                                     .none,
//                               )),
//                         ),
//                       ),
//                       Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius
//                                 .circular(
//                                 20)),
//                         child: TextFormField(
//                           controller:
//                           agecontroller,
//                           textInputAction:
//                           TextInputAction
//                               .next,
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return "Enter age...";
//                             }
//                           },
//                           onSaved: (val) {
//                             setState(() {
//                               ages = int.parse(
//                                   val!);
//                             });
//                             print(ages);
//                           },
//                           keyboardType:
//                           TextInputType
//                               .number,
//                           decoration:
//                           InputDecoration(
//                               prefixIcon:
//                               Icon(
//                                 Icons
//                                     .real_estate_agent_rounded,
//                                 color: Colors
//                                     .black,
//                               ),
//                               hintText:
//                               "Age",
//                               hintStyle: TextStyle(
//                                   color: Colors
//                                       .grey[
//                                   400]),
//                               filled: true,
//                               fillColor:
//                               Colors
//                                   .white,
//                               border:
//                               OutlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.circular(
//                                     20),
//                                 borderSide:
//                                 BorderSide
//                                     .none,
//                               )),
//                         ),
//                       ),
//                       Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius
//                                 .circular(
//                                 20)),
//                         child: TextFormField(
//                           controller:
//                           coursecontroller,
//                           textInputAction:
//                           TextInputAction
//                               .next,
//                           validator: (val) {
//                             if (val!.isEmpty) {
//                               return "Enter course...";
//                             }
//                           },
//                           onSaved: (val) {
//                             setState(() {
//                               courses = val;
//                             });
//                             print(courses);
//                           },
//                           decoration:
//                           InputDecoration(
//                               prefixIcon:
//                               Icon(
//                                 Icons
//                                     .subject,
//                                 color: Colors
//                                     .black,
//                               ),
//                               hintText:
//                               "Course",
//                               hintStyle: TextStyle(
//                                   color: Colors
//                                       .grey[
//                                   400]),
//                               filled: true,
//                               fillColor:
//                               Colors
//                                   .white,
//                               border:
//                               OutlineInputBorder(
//                                 borderRadius:
//                                 BorderRadius.circular(
//                                     20),
//                                 borderSide:
//                                 BorderSide
//                                     .none,
//                               )),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment
//                         .center,
//                     children: [
//                       OutlinedButton(
//                           onPressed: () {
//                             namecontroller
//                                 .clear();
//                             agecontroller
//                                 .clear();
//                             coursecontroller
//                                 .clear();
//
//                             setState(() {
//                               names = null;
//                               ages = null;
//                               courses = null;
//                               image = null;
//                             });
//
//                             Navigator.pop(
//                                 context);
//                           },
//                           child:
//                           Text("Cancel")),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       ElevatedButton(
//                           onPressed: () async {
//                             if (updateformKey
//                                 .currentState!
//                                 .validate()) {
//                               updateformKey
//                                   .currentState!
//                                   .save();
//
//                               Student s1 =
//                               Student(
//                                 name: names!,
//                                 age: ages!,
//                                 course:
//                                 courses!,
//                                 image: image,
//                               );
//
//                               int res = await DBHelper
//                                   .dbHelper
//                                   .update(
//                                   data: s1,
//                                   id: data[
//                                   i]
//                                       .id!);
//
//                               if (res == 1) {
//                                 setState(() {
//                                   getAllStudent =
//                                       DBHelper
//                                           .dbHelper
//                                           .fetchAllStudents();
//                                 });
//
//                                 ScaffoldMessenger.of(
//                                     context)
//                                     .showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                         "Record update successfully"),
//                                     backgroundColor:
//                                     Colors
//                                         .green,
//                                     behavior:
//                                     SnackBarBehavior
//                                         .floating,
//                                   ),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(
//                                     context)
//                                     .showSnackBar(
//                                   SnackBar(
//                                     content: Text(
//                                         "Record updation failed"),
//                                     backgroundColor:
//                                     Colors
//                                         .red,
//                                     behavior:
//                                     SnackBarBehavior
//                                         .floating,
//                                   ),
//                                 );
//                               }
//                               Navigator.pop(
//                                   context);
//                             }
//                             namecontroller
//                                 .clear();
//                             agecontroller
//                                 .clear();
//                             coursecontroller
//                                 .clear();
//
//                             setState(() {
//                               names = null;
//                               ages = null;
//                               courses = null;
//                               image = null;
//                             });
//                           },
//                           child:
//                           Text("Update")),
//                     ],
//                   )
//                 ],
//               ),
//             );
//           },
//           icon: Icon(
//             Icons.edit,
//             color: Colors.blue,
//           )),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// editReminder(
//     {required ReminderDB reminder, required BuildContext context}) async {
//   ReminderController reminderController = Get.find();
//
//   final key = GlobalKey<FormState>();
//   String title = "";
//   String description = "";
//
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descController = TextEditingController();
//
//   reminderController.setDateTime(
//       hourVal: reminder.hour, minuteVal: reminder.minute);
//   titleController.text = reminder.title;
//   descController.text = reminder.description;
//
//   Get.dialog(
//     AlertDialog(
//       scrollable: true,
//       title: const Text("Update Reminder"),
//       content: Form(
//         key: key,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(height: 20),
//             TextFormField(
//                 controller: titleController,
//
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//
//                   ),
//                   labelText: "Title", hintText: "Enter Reminder title hear",
//                     ),
//               validator: (val) => (val!.isEmpty) ? "Enter Title First" : null,
//               onSaved: (val) {
//                 title = val!;
//               },
//             ),
//             const SizedBox(height: 15),
//             TextFormField(
//               controller: descController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//
//                 ),
//                   labelText: "Description", hintText: "Enter Description hear",
//                   ),
//
//               validator: (val) =>
//                   (val!.isEmpty) ? "Enter Description First" : null,
//               onSaved: (val) {
//                 description = val!;
//               },
//             ),
//             const SizedBox(height: 15),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     dateTimePickerEdit(context, reminderController);
//                   },
//                   icon: const Icon(Icons.watch_later_outlined),
//                 ),
//                 // Text("data"),
//                 Expanded(
//                   child: Obx(
//                     () => (reminderController.hour.value != 0)
//                         ? Text(
//                             "${(reminderController.hour.value > 12) ? reminderController.hour.value - 12 : reminderController.hour.value}:${reminderController.minute.value} ${(reminderController.hour.value > 12) ? "PM" : "AM"}",
//                             style: Theme.of(context).textTheme.titleMedium)
//                         : const Text(""),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         OutlinedButton(
//           onPressed: () {
//             Get.back();
//           },
//           child: const Text("Cancel"),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (key.currentState!.validate()) {
//               key.currentState!.save();
//
//               if (reminderController.hour.value != 0) {
//                 ReminderDB reminderDB = ReminderDB(
//                     id: reminder.id,
//                     title: title,
//                     description: description,
//                     hour: reminderController.hour.value,
//                     minute: reminderController.minute.value);
//
//                 Reminder reminder2 = Reminder(
//                     title: title,
//                     description: description,
//                     hour: reminderController.hour.value,
//                     minute: reminderController.minute.value);
//
//                 NotificationHelper.notificationHelper
//                     .scheduleNotification(reminder: reminder2);
//                 DBHelper.dbHelper.updateReminder(reminder: reminderDB);
//                 reminderController.clearDateTime();
//                 Get.back();
//               }
//             }
//           },
//           child: const Text("Update"),
//         ),
//       ],
//     ),
//   );
// }
//
// dateTimePickerEdit(context, ReminderController reminderController) {
//   showTimePicker(
//     context: context,
//     initialTime: TimeOfDay(
//         minute: reminderController.minute.value,
//         hour: reminderController.hour.value),
//   ).then((TimeOfDay? value1) {
//     if (value1 != null) {
//       reminderController.setDateTime(
//           hourVal: value1.hour, minuteVal: value1.minute);
//     }
//   });
// }
