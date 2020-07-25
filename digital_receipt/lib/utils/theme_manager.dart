import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:theme_provider/theme_provider.dart';

import '../colors.dart';

class MyThemeOptions implements AppThemeOptions {
  final Color specificButtonColor;
  MyThemeOptions(this.specificButtonColor);
}

class ThemeManager {
  static String lightTheme = 'light';
  static String darkTheme = 'dark';

  static void onInitCallback(controller, previouslySavedThemeFuture) async {
    String savedTheme = await previouslySavedThemeFuture;

    if (savedTheme != null) {
      // If previous theme saved, use saved theme
      controller.setTheme(savedTheme);
    } else {
      // If previous theme not found, use platform default
      Brightness platformBrightness =
          SchedulerBinding.instance.window.platformBrightness;
      if (platformBrightness == Brightness.dark) {
        controller.setTheme(ThemeManager.darkTheme);
      } else {
        controller.setTheme(ThemeManager.lightTheme);
      }
      // Forget the saved theme(which were saved just now by previous lines)
      controller.forgetSavedTheme();
    }
  }

  static AppTheme light() => AppTheme.light().copyWith(
        id: lightTheme,
        data: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: LightMode.backgroundColor,
          primaryColor: LightMode.primaryColor,
          primaryColorDark: LightMode.appBarColor,
          dialogBackgroundColor: LightMode.backgroundColor,
          cardColor: Color(0xFFE2EAF3),
          accentColor: Color(0xFF25CCB3),
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                letterSpacing: 0.03,
              ),
            ),
          ),
          buttonColor: LightMode.buttonColor,
          focusColor: LightMode.focusColor,
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
            bodyText2: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                fontSize: 14,
                letterSpacing: 0.3),
            subtitle2: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.normal,
              letterSpacing: 0.3,
              color: LightMode.textFieldFocusedColor,
            ),
            headline5: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              fontSize: 22,
            ),
            headline6: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
              fontSize: 16,
            ),
            button: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.all(15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: LightMode.textFieldRingColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: LightMode.textFieldFocusedColor, width: 1.5),
            ),
            hintStyle: TextStyle(
              color: LightMode.textFieldEnabledColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat',
            ),
            errorStyle: TextStyle(height: 0.5),
          ),
          tabBarTheme: TabBarTheme(
            labelColor: LightMode.primaryColor,
            labelStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
              fontSize: 16,
            ),
          ),
        ),
      );

  static AppTheme dark() {
    return AppTheme.dark().copyWith(
      id: darkTheme,
      data: ThemeData(
        cardColor: DarkMode.appBarColor,
        brightness: Brightness.dark,
        //scaffoldBackgroundColor: Colors.purple,
        scaffoldBackgroundColor: DarkMode.backgroundColor,
        primaryColor: DarkMode.primaryColor,
        primaryColorDark: DarkMode.appBarColor,
        accentColor: Color(0xFF25CCB3),
        dialogBackgroundColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: DarkMode.appBarColor,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              letterSpacing: 0.03,
            ),
          ),
        ),
        buttonColor: DarkMode.buttonColor,
        focusColor: DarkMode.focusColor,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: DarkMode.appBarColor,
            fontFamily: 'Montserrat',
          ),
          bodyText2: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              letterSpacing: 0.3),
          subtitle2: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.normal,
            letterSpacing: 0.3,
            color: Color(0x99FFFFFF),
          ),
          headline5: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            fontSize: 22,
          ),
          headline6: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            fontSize: 16,
          ),
          button: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: DarkMode.appBarColor,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            fontSize: 16,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                BorderSide(color: DarkMode.textFieldRingColor, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                BorderSide(color: DarkMode.textFieldFocusedColor, width: 1.5),
          ),
          hintStyle: TextStyle(
            color: DarkMode.textFieldEnabledColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
          errorStyle: TextStyle(height: 0.5),
        ),
      ),
      //
    );
  }
}
