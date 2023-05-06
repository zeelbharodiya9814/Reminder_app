import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class addReminder extends StatefulWidget {
  const addReminder({Key? key}) : super(key: key);

  @override
  State<addReminder> createState() => _addReminderState();
}

class _addReminderState extends State<addReminder> {

  DateTime currentDateTime = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
     appBar: AppBar(
       backgroundColor: Colors.grey[100],
       centerTitle: true,
       title: Text("Add New Reminder",style: TextStyle(fontSize: 21,fontWeight: FontWeight.w700,color: Colors.black,fontFamily: GoogleFonts.kanit().fontFamily,letterSpacing: 2,),),
     ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0,top: 12),
            child: Row(
              children: [
                Text("Title",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: GoogleFonts.kanit().fontFamily,letterSpacing: 2,),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0,top: 3,right: 12),
            child:  Container(
              // height: 100,
              // width: double.infinity,
              margin: EdgeInsets.only(top: 4,bottom: 10),
              alignment:Alignment.center,
              child: Center(
                child: TextField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    // hintText: "Title...",
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0,top: 12),
            child: Row(
              children: [
                Text("Date",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black,fontFamily: GoogleFonts.kanit().fontFamily,letterSpacing: 2,),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0,top: 3,right: 12),
            child:  GestureDetector(
              onTap: () async {

                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDateTime,
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2025),
                  // cancelText: "",
                  // confirmText: "",
                  // helpText: "",
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDatePickerMode: DatePickerMode.year,
                );

                setState(() {
                  if (pickedDate != null) {
                    currentDateTime = pickedDate;
                  }
                });
              },
              child: Container(
                // height: 100,
                // width: double.infinity,
                margin: EdgeInsets.only(top: 4,bottom: 10),
                alignment:Alignment.center,
                child: Center(
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(15),
                      // hintText: "Title...",
                      suffixIcon: Icon(Icons.calendar_month,color: Colors.blue,),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
