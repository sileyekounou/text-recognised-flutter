import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:texto/camera.dart';
import 'package:texto/history.dart';
import 'package:texto/option.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, this.customPaint});
  final CustomPaint? customPaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 80, 59, 1),
        title: Text(
          'Text Snap App',
          style: GoogleFonts.lexend(
              color: Color.fromRGBO(176, 225, 101, 1), fontSize: 32),
        ),
      ),
      backgroundColor: Color.fromRGBO(36, 80, 59, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCameraPage()));
              },
              child: MyOption(
                  linkSvg: 'assets/camera_broken.svg', libelle: 'Camera'),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyHistory()));
                },
                child: MyOption(
                    linkSvg: 'assets/history.svg', libelle: 'History')),
          ],
        ),
      ),
    );
  }
}
