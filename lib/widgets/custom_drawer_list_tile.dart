// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import '../homescreen/language/language.dart';

class CustomDrawerList extends StatelessWidget {
  String image;
  String text;
  void Function() onTap;

  CustomDrawerList(this.image, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:EdgeInsets.symmetric(horizontal: 20,vertical: 10), 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(
                image,
              ),
              height: 28,
              width: 28,
              alignment: Alignment.topCenter,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
