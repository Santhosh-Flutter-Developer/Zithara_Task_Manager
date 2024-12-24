// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zithara_task_manager/controllers/login_controller.dart';
import 'package:zithara_task_manager/ui/theme.dart';

class LoginPage extends StatelessWidget {
   const LoginPage({super.key});
 

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return GetBuilder<LoginController>(
      initState: (val) {
          Get.isRegistered<LoginController>()
              ? Get.find<LoginController>()
              : Get.put(LoginController());
        },
      builder:(controller) => Scaffold(
      backgroundColor: bluishClr,
      body: SafeArea(
        child: Column(
          children: [
            //to give space card from top
            const Expanded(
              flex: 1,
              child: Center(),
            ),

            //page content
            Expanded(
              flex: 11,
              child: controller.buildCard(size,context),
            ),
          ],
        ),
      )),
    );
  }
   
}


