import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../utils/colors.dart';

ThemeData mainTheme() => ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: dark,
      appBarTheme: const AppBarTheme(
        backgroundColor: back,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts.raleway(
          fontSize: 18.sp,
          color: textBlack,
          fontWeight: FontWeight.w600,
        ),
        bodyText1: GoogleFonts.raleway(
          fontSize: 18.sp,
          color: textBlack,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
