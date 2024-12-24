import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zithara_task_manager/ui/theme.dart';


class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final String? Function(String?)? validator;
  final bool? maxLine;
  const InputField({super.key, required this.title, required this.hint, required this.controller, this.widget, this.validator, this.maxLine});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14.0),
            height:maxLine==true?100: 52,
                       decoration: BoxDecoration(
             
              border: Border.all(
                color: grey,
                width: 1.0
              ),
              borderRadius: BorderRadius.circular(8.0)
            ),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(child:TextFormField(
                  readOnly: widget==null?false:true,
                  autofocus: false,
                  maxLines: maxLine==true?4:1,
                  validator: validator??(val){
                    return null;
                  },
                  cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                  controller: controller??TextEditingController(),
                  style: subTitleStyle,
                  decoration:InputDecoration(
      hintText: hint,
      hintStyle: subTitleStyle,
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: context.theme.scaffoldBackgroundColor,
          width: 0.0
        )
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: context.theme.scaffoldBackgroundColor,
          width: 0.0
        )
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: context.theme.scaffoldBackgroundColor,
          width: 0.0
        )
      ),
      errorStyle: TextStyle(
        color: Colors.transparent,
        fontSize: 0
      ),
    
      enabledBorder:  UnderlineInputBorder(
        borderSide: BorderSide(
          color: context.theme.scaffoldBackgroundColor,
          width: 0.0
        )
      ),
    )
                ) ),
                widget??SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}