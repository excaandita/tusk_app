import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tusk_app/common/app_color.dart';

class FailedUI extends StatelessWidget {
  const FailedUI({super.key, this.icon, required this.message, this.margin});
  final IconData? icon;
  final String message;
  final EdgeInsetsGeometry? margin;

  @override 
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)
        ), 
        child: Column(
          children: [
            Icon(
              icon?? Icons.error,
              size: 30,
              color: Colors.grey,
            ),
            const Gap(20),
            Text(
              message,
              style: TextStyle(
                color: AppColor.textBody
              ),
            )
          ],
        ),
      ),
    );
  }
}