// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ogas_driver_app/util/colors.dart';

import '../homescreen/language/language.dart';

class LanguageModel extends StatefulWidget {
  final String? lname;
  final void Function(Object?)? onChanged;
  final int? groupValue;
  final double? height;
  final double? width;
  final double? fontSize;
  final void Function()? onTap;
  final BoxBorder? border;
  final int? value;

  const LanguageModel(
      {Key? key,
      this.lname,
      this.onChanged,
      this.groupValue,
      this.height,
      this.width,
      this.fontSize,
      this.onTap,
      this.border,
      this.value})
      : super(key: key);

  @override
  State<LanguageModel> createState() => _LanguageModelState();
}

class _LanguageModelState extends State<LanguageModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 15 , right: 15),
        alignment: ggvalue == 0 ?  Alignment.centerLeft : Alignment.centerRight,
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: widget.border,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lname ?? "",
                  style: TextStyle(
                      fontSize: widget.fontSize, // fontWeight: FontWeight.bold
                      ),
                ),
              ],
            ),
            Radio<int>(
              value: widget.value ?? 0,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
              activeColor: ColorConstnt.mainorange,
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.selected)) {
                  return ColorConstnt.mainorange;
                }
                return ColorConstnt.mainorange;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
