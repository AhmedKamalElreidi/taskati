import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskati/core/utils/colors.dart';

TextStyle getHeadlineStyle({double fontSize = 18}) {
  return TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: fontSize,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.bold,
  );
}

TextStyle getTitleStyle({Color color = Colors.black, double fontSize = 18}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.bold,
  );
}

TextStyle getSubTitleStyle({Color color = Colors.black, double fontSize = 16}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
  );
}

TextStyle getSmallTextStyle({Color color = Colors.grey, double fontSize = 14}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
  );
}
