import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color alertColor = const Color(0xffED6363);
Color alertStrokeColor = const Color(0xffDB3029);
Color bgColor1 = const Color(0xffF2F2F3);
Color bgColor2 = const Color(0xffF5F5F5);
Color bgColor3 = const Color(0xff3750b2);
Color primaryTextColor = const Color(0xff1F292E);
Color secondaryTextColor = const Color(0xff415058);
Color whiteSecondaryTextColor = const Color(0xffE6E6E6);
Color greenTextColor = const Color(0xff6BC73D);
Color redTextColor = const Color(0xffE02424);
Color blueTextColor = const Color(0xff1449D1);
Color strokeColor = const Color(0xffBDC0C2);
Color greyColor = const Color(0xffA3A6A9);
Color transparentColor = Colors.transparent;

TextStyle primaryTextStyle = GoogleFonts.rubik(color: primaryTextColor);

TextStyle secondaryTextStyle = GoogleFonts.rubik(color: secondaryTextColor);

TextStyle whiteTextStyle = GoogleFonts.rubik(color: bgColor1);

TextStyle secondaryWhiteTextStyle =
    GoogleFonts.rubik(color: whiteSecondaryTextColor);

TextStyle blueTextStyle = GoogleFonts.rubik(color: blueTextColor);

TextStyle purpleTextStyle = GoogleFonts.rubik(color: bgColor3);

TextStyle greenTextStyle = GoogleFonts.rubik(color: greenTextColor);

TextStyle redTextStyle = GoogleFonts.rubik(color: redTextColor);

TextStyle dottedTextStyle = GoogleFonts.rubik(
  color: primaryTextColor,
  decoration: TextDecoration.underline,
  decorationThickness: 3,
  decorationStyle: TextDecorationStyle.dotted,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

ThemeData tableTheme = ThemeData(
    cardColor: Colors.white,
    cardTheme: CardTheme(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0), // Change radius
      ),
    ));
