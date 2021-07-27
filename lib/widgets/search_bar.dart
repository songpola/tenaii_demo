import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 326,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(68),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            offset: const Offset(-2, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 10),
          hintText: "ตามหาอะไรอยู่",
          hintStyle: GoogleFonts.prompt(color: Colors.black54, fontSize: 18),
          prefixIcon: IconButton(
            icon: SvgPicture.asset(
              "assets/search.svg",
              width: 18,
              height: 18,
            ),
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
