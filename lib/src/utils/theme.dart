import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:publicart/src/utils/colors.dart';

ThemeData mainTheme() => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: TextTheme(
        headline1: GoogleFonts.raleway(
          fontSize: 18,
          color: textBlack,
          fontWeight: FontWeight.w600,
        ),
        bodyText1: GoogleFonts.raleway(
          fontSize: 18,
          color: textBlack,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
