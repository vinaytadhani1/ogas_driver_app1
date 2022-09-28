import 'package:flutter/material.dart';

class GreyborderCont extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? width;
  final Widget? child;

  const GreyborderCont(
      {Key? key,
      this.padding,
      this.margin,
      this.height,
      this.width,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 1.0,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
