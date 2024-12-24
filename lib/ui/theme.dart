
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;
const Color red = Colors.red;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);


class Themes {

static final light = ThemeData(
  scaffoldBackgroundColor: white,
  primaryColor: primaryClr,
  brightness: Brightness.light,
  useMaterial3: false,
);

static final dark = ThemeData(
  scaffoldBackgroundColor: darkGreyClr,
  primaryColor: darkGreyClr,
  brightness: Brightness.dark,
   useMaterial3: false,
);

}


TextStyle get subHeadingStyle{
  return GoogleFonts.lato(textStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode? Colors.grey[400]:Colors.grey,

  ));
}

TextStyle get headingStyle{
  return GoogleFonts.lato(textStyle: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode? white:black,
    
  ));
}

TextStyle get titleStyle{
  return GoogleFonts.lato(textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode? white:black,
    
  ));
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode? Colors.grey[100]:Colors.grey[600],
    
    
  ));
}