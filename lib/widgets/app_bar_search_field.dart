import 'package:flutter/material.dart';

class AppBarSearchField extends StatelessWidget {
  const AppBarSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0f101828),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
            BoxShadow(
              color: Color(0x19101828),
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ]),
      padding: const EdgeInsets.only(right: 18.0),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search anything",
          hintStyle: const TextStyle(color: Colors.grey, height: 1.4),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
              size: 17,
            ),
          ),
          suffixIconConstraints: BoxConstraints.loose(const Size.square(40)),
          suffixIcon: Container(
            padding: const EdgeInsets.only(left: 7),
            height: 17,
            decoration: const BoxDecoration(
                border: Border(left: BorderSide(width: 1, color: Colors.grey))),
            child: const Icon(
              Icons.pageview_outlined,
              color: Colors.grey,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}