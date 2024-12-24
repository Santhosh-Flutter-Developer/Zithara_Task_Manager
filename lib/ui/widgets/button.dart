import 'package:flutter/material.dart';
import 'package:zithara_task_manager/ui/theme.dart';

class ZitharaButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const ZitharaButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap??(){},
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: primaryClr
        ),
        child: Center(
          child: Text(label,style: TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}