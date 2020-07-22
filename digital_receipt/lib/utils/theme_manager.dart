import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ThemeManager {
  static String lightTheme = 'light';
  static String darkTheme = 'dark';

  static AppTheme light() => AppTheme.light().copyWith(
        id: lightTheme,
        data: ThemeData(
          primaryColor: Color(0xFF0B57A7),
          scaffoldBackgroundColor: Color(0xFFF2F8FF),
          accentColor: Color(0xFF25CCB3),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
              letterSpacing: 0.03,
            ),
          )),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'Montserrat',
            ),
            headline6: TextStyle(
              fontFamily: 'Montserrat',
            ),
            bodyText2: TextStyle(
              fontFamily: 'Montserrat',
            ),
            button: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      );

  static AppTheme dark() => AppTheme.dark().copyWith(
        id: darkTheme,
        data: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.grey[850],
          primaryColorLight: ,
          accentColor: Color(0xFF25CCB3),
          appBarTheme: AppBarTheme(
              brightness: Brightness.dark,
              textTheme: TextTheme(
                headline6: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  letterSpacing: 0.03,
                ),
              )),
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'Montserrat',
            ),
            headline6: TextStyle(
              fontFamily: 'Montserrat',
            ),
            bodyText2: TextStyle(
              fontFamily: 'Montserrat',
            ),
            button: TextStyle(
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      );
}
