import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zithara_task_manager/ui/theme.dart';


class NotifiedPage extends StatelessWidget {
  final String? label;
  const NotifiedPage({this.label,super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.isDarkMode? Colors.grey[600]:Colors.white,
        leading: IconButton(onPressed: (){
Get.back();
        }, icon: Icon(Icons.arrow_back_ios,color: Get.isDarkMode?Colors.white:Colors.grey,)),
        title: Text(label.toString().split("|")[0].toString(),
        
        style: TextStyle(
         color: Get.isDarkMode?Colors.white:Colors.grey,
        ),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode?Colors.white:Colors.grey[400]
          ),
          child: Center(
            child: Text(label.toString().split("|")[1].toString(),style: TextStyle(
              color:Get.isDarkMode?black: white,
              fontSize: 30
            ),),
          ),
        ),
      ),
    );
  }
}