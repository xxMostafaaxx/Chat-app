import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomButton({
required String text,
 required VoidCallback? onTap,
})=> Padding(
  padding: const EdgeInsets.symmetric(horizontal: 100),
  child:   GestureDetector(
    onTap: onTap,
    child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)
                  ),
                  width: double.infinity,
                  height: 50,
      child: Center(
        child: Text(
                  text,
                  style: GoogleFonts.gemunuLibre(
                  textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                  )
                  ),
                  ),
                  ),
                  ),
                ),
);