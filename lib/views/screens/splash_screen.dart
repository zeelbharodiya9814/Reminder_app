import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/theme_controller.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 4), (timer) {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white,width: 0),
                color: Colors.white,
                image: DecorationImage(image: AssetImage("assets/images/logo.jpg"),fit: BoxFit.fill,),
              ),
            ),
            SizedBox(height: 5,),
            Text("Reminder App",style: TextStyle(fontSize: 22,fontFamily: GoogleFonts.abel().fontFamily,letterSpacing: 1,color: Provider.of<ThemeProvider>(context).tm1.isDark
                ? Colors.white
                : Colors.black,),)
          ],
        ),
      ),
    );
  }
}
