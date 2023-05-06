import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:pr_reminder_app/views/screens/add_reminder_page.dart';
import 'package:pr_reminder_app/views/screens/profile_page.dart';
import 'package:pr_reminder_app/views/screens/reminderpage.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _pageController = PageController(initialPage: 2);

  int maxCount = 5;


  final List<Widget> bottomBarPages = [
     Reminder(),
     addReminder(),
     Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        pageController: _pageController,
        color: Colors.white,
        showLabel: false,
        notchColor: Colors.white,
        showShadow: true,
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.home_outlined,
              color: Colors.blue,size: 30,
            ),
            activeItem: Icon(
              Icons.home_outlined,
              color: Colors.green,
            ),
            itemLabel: 'Page 1',
          ),
          const BottomBarItem(
            inActiveItem: Icon(
              Icons.add,
              color: Colors.blue,size: 30,
            ),
            activeItem: Icon(
              Icons.add,
              color: Colors.green,
            ),
            itemLabel: 'Page 2',
          ),

          ///svg example
          BottomBarItem(
            inActiveItem: Icon(Icons.person_outline,color: Colors.blue,size: 30,),
            activeItem: Icon(Icons.person_outline,color: Colors.green,),
            itemLabel: 'Page 3',
          ),
        ],
        onTap: (index) {
          /// control your animation using page controller
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeIn,
          );
        },
      )
          : null,
    );
  }
}
