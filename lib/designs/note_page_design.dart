import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotePageDesign{
  static Widget textFormField({
    required TextEditingController controller,
    required double cursorHeight,
    required Color cursorColor,
    required double fontSize,
    required FontWeight fontWeight,
    required String hintText
  }){
    return TextFormField(
      controller: controller,
      cursorHeight: cursorHeight,
      cursorColor: cursorColor,
      style: GoogleFonts.quicksand(
          fontSize: fontSize,
          color: Colors.black,
          fontWeight: fontWeight
      ),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.quicksand(
            fontSize: fontSize,
            color: Colors.grey.shade600,
            fontWeight: fontWeight,
          ),
          border: InputBorder.none
      ),
    );
  }
}