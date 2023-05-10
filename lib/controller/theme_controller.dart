




import 'package:flutter/cupertino.dart';
import '../modals/theme_model.dart';


class ThemeProvider extends ChangeNotifier {

  ThemeModel tm1 = ThemeModel(isDark: false);

  void changetheme() {
    tm1.isDark = !tm1.isDark;
    notifyListeners();
  }
}