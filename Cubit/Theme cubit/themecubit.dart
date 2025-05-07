import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constans.dart';
import '../../core/utils/Theme/ThemeData/Dark_Theme_Data.dart';
import '../../core/utils/Theme/ThemeData/Light_Theme_Data.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lighttheme) {
    _loadTheme();
  }


  // static final ThemeData lighttheme = ThemeData(
  //
  //   buttonTheme: ButtonThemeData(
  //
  //       buttonColor: Colors.transparent.withOpacity(.18)
  //
  //
  //   ),
  //   textTheme: TextTheme(
  //     bodyLarge: TextStyle(color: KLSecondarycolor ,)
  //
  //
  //
  //
  //   ),
  //
  //
  //   appBarTheme: AppBarTheme(
  //       backgroundColor: KLPrimarycolor
  //   ),
  //
  //   brightness:  Brightness.light ,
  //   colorScheme: ColorScheme.light(
  //     inversePrimary: KLSecondarycolor,
  //     tertiaryContainer: KLSPIDERMENU,
  //     outline: KLThirdarycolor,
  //     surfaceBright: KLSecondarycolor,
  //       surface: KLPrimarycolor, // background
  //           tertiary: KLclipgredient1 ,//clip gredient
  //     onTertiary: KLclipgredient2 , // ,
  //     secondary: Colors.white, // containar
  //     onSecondary: Colors.transparent.withOpacity(.18) ,
  //     primaryContainer: Colors.grey.withOpacity(0.1) ,
  //     tertiaryFixed: KLSecondarycolor ,
  //       secondaryContainer: KLPrimarycolor ,
  //     errorContainer: Colors.black
  //
  //
  //
  //   ) ,
  // );
  // ThemeData darktheme = ThemeData(
  //
  //
  //
  //
  //
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: Colors.pink
  //
  //
  //   ),
  //
  //   textTheme: TextTheme(
  //       bodyLarge: TextStyle(color: KLPrimarycolor,)
  //
  //
  //
  //
  //   ),
  //
  //
  //
  //
  //   appBarTheme: AppBarTheme(
  //       backgroundColor: KDSecondarycolor
  //   ),
  //   brightness:  Brightness.dark ,
  //   colorScheme: ColorScheme.dark(
  //     errorContainer:  Colors.white,
  //     inversePrimary: Colors.black,
  //       secondaryContainer: Colors.black ,
  //     tertiaryFixed: Colors.white,
  //     primaryContainer: Colors.black,
  //     tertiaryContainer: KDSPIDERMENU,
  //
  //     surfaceBright: KDSecondarycolor,
  //     outline: KDThirdarycolor,
  //
  //     surface: KDPrimarycolor,
  //       tertiary: KDclipgredient ,//clip gredient
  //       onTertiary: KDclipgredient ,
  //     secondary: Colors.black,
  //       onSecondary: Colors.pink
  //   ) ,
  //
  // );

  void toggleTheme() {
    if (state.brightness == Brightness.dark) {
      emit(lighttheme);
      _saveTheme(false);
    } else {
      emit(darktheme);
      _saveTheme(true);
    }
  }

  void _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode);
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode ? darktheme : lighttheme);
  }
}
