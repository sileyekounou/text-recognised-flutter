import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Result Of Scan', style: GoogleFonts.lexend(color: Color.fromRGBO(176, 225, 101, 1), fontSize: 32),),
          backgroundColor: Color.fromRGBO(36, 80, 59, 1),
        ),
        backgroundColor: Color.fromRGBO(36, 80, 59, 1),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Text(text, style: GoogleFonts.lexend(color: Color.fromRGBO(176, 225, 101, 1), fontSize: 18 ),),
          ),
        ),
      );
}
