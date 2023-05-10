// class Reminder {
//   final String title;
//   final String description;
//   final String hour;
//   // final int minute;
//
//   Reminder({
//     required this.title,
//     required this.description,
//     required this.hour,
//     // required this.minute,
//   });
// }

class ReminderDB {
   int? id;
   String title;
   String description;
   String hour;
   String? date;

  ReminderDB({
     this.id,
    required this.title,
    required this.description,
    required this.hour,
     this.date,
  });

  factory ReminderDB.fromMap({required Map data}) {
    return ReminderDB(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      hour: data["hour"],
      date: data["date"],
    );
  }
}
