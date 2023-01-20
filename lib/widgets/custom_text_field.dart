import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ogas_driver_app/util/colors.dart';

import '../homescreen/language/language.dart';
import 'textstyle.dart';

class CustomTextField extends StatelessWidget {
  final String? mName;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    this.mName,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.readOnly,
    this.keyboardType,
    this.validator,
    this.maxLength,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          alignment: ggvalue == 0 ?  Alignment.topLeft : Alignment.topRight,
          child: Text(mName ?? "",
              style: largetitleStyle ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: TextFormField(
            smartDashesType: SmartDashesType.enabled,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintStyle: const TextStyle(
                // fontWeight: FontWeight.w400,
                color: ColorConstnt.grey,
                fontSize: 16,
              ),
              hintText: hintText ?? "",
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff212121), width: 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
