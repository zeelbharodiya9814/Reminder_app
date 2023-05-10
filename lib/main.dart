import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pr_reminder_app/views/screens/add_reminder_page.dart';
import 'package:pr_reminder_app/views/screens/homepage.dart';
import 'package:pr_reminder_app/views/screens/profile_page.dart';
import 'package:pr_reminder_app/views/screens/reminderpage.dart';
import 'package:pr_reminder_app/views/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'controller/theme_controller.dart';
import 'helpers/db_helper.dart';






void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  // DBHelper.dbHelper.fetchAllRecords();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: (Provider.of<ThemeProvider>(context).tm1.isDark == false)
                ? ThemeMode.light
                : ThemeMode.dark,
            initialRoute: 'Splash_screen',
            routes: {
              '/': (context) => HomePage(),
              'ReminderPage': (context) => ReminderPage(),
              'Splash_screen': (context) => Splash_screen(),
              'addReminder': (context) => addReminder(),
              'Profile': (context) => Profile(),
            },
          );
        }
      ),
    ),
  );
}