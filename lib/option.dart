import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOption extends StatelessWidget {
  final String linkSvg;
  final String libelle;
  MyOption({super.key, required this.linkSvg, required this.libelle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Color.fromRGBO(176, 225, 101, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                linkSvg,
                width: 40,
                height: 40,
              ),
            ),
          ),
          Text(
            libelle,
            style: GoogleFonts.lexend(
                textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    inherit: true,
                    color: Color.fromRGBO(176, 225, 101, 1))),
          ),
        ],
      ),
    );
  }
}
