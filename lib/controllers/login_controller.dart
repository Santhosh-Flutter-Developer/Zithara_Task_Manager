import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zithara_task_manager/ui/home_page.dart';
import 'package:zithara_task_manager/ui/theme.dart';
import 'package:zithara_task_manager/ui/widgets/input_field.dart';

class LoginController extends GetxController{
TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
RxBool obscureText=true.obs;
RxBool emailval=false.obs;
RxBool passval=false.obs;
 final _formKey = GlobalKey<FormState>();


Widget buildCard(Size size,BuildContext context) {
    return Obx(()=>Container(
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color:Get.isDarkMode?darkGreyClr: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: SingleChildScrollView(
          padding:const EdgeInsets.only(bottom: 100),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                SizedBox(
                  height: size.height * 0.02,
                ),
            
                //welcome text
                Text(
                  'Welcome Back!',
                  style: GoogleFonts.inter(
                    fontSize: 22.0,
                    color:Get.isDarkMode?Colors.grey[100]: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Let’s login for explore continues',
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: const Color(0xFF969AA8),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
            
                //logo section
                logo(80, 80),
                SizedBox(
                  height: size.height * 0.02,
                ),
            
            
                //email textField
                
               InputField(title: "Email", hint: "Enter your email", controller: emailController,validator: (value) {
                if(value!.isEmpty){
                    emailval.value=true;
                    emailval.refresh();
                  }else{
                    emailval.value=false;
                    emailval.refresh();
                  }
                 return value.isEmpty ? "Email required" : null;
               },),
               if(emailval.value)
               Text("Email is required",style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: red,
                  fontSize: 12
                )
               ),),     
                
            
                //password textField
                InputField(title: "password", hint: "Enter your password", controller: passController,validator: (value) {
                  if(value!.isEmpty){
                    passval.value=true;
                    passval.refresh();
                  }else{
                    passval.value=false;
                    passval.refresh();
                  }
                  return value.isEmpty ? "Password required" : null;
                },),
                if(passval.value)
                Text("Password is required",style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: red,
                  fontSize: 12
                )
               ),), 
            
             SizedBox(
                  height: size.height * 0.03,
                ),
                //sign in button
                logInButton(size),
                
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/images/appicon.png',
      height: height_,
      width: width_,
    );
  }

Widget logInButton(Size size) {
    return // Group: Button
        InkWell(
          onTap: (){
              if (_formKey.currentState!.validate()) {
           Get.offAll(HomePage());}
          },
          child: Container(
                alignment: Alignment.center,
                height: size.height / 13,
                decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color:bluishClr,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
                ),
                child: Text(
          'Log In',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
                ),
              ),
        );
  }

}