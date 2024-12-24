import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zithara_task_manager/controllers/task_controller.dart';
import 'package:zithara_task_manager/models/task.dart';
import 'package:zithara_task_manager/ui/theme.dart';
import 'package:zithara_task_manager/ui/widgets/button.dart';
import 'package:zithara_task_manager/ui/widgets/input_field.dart';


class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String _endTime = "09:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList =[
    5,
    10,
    15,
    20
  ];

String _selectedRepeat = "None";
  List<String> repeatList =[
    "None",
     "Daily",
    "Weekly",
    "Monthly"
  ];
  int _selectedColor =0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.theme.scaffoldBackgroundColor,
appBar: _appBar(context),
body: Container(
  padding:const EdgeInsets.only(left: 20.0,right: 20.0),
  child: SingleChildScrollView(
    padding: EdgeInsets.only(bottom: 100),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Add Task",
        style: headingStyle,
        ),
        InputField(title: "Title", hint: "Enter your title", controller: _titleController),
         InputField(title: "Description", hint: "Enter your Description", controller: _descriptionController,maxLine: true,),
         Row(
           children: [
             Expanded(
               child: InputField(title: "Start Date", hint: DateFormat.yMd().format(_startDate), controller: TextEditingController(),widget: IconButton(onPressed: (){
               _getDateFromUser(isStartDate: true);
               }, icon: Icon(Icons.calendar_today_outlined,color: grey,),iconSize: 20,),),
             ),
             SizedBox(
          width: 12.0,
         ),
             Expanded(
               child: InputField(title: "End Date", hint: DateFormat.yMd().format(_endDate), controller: TextEditingController(),widget: IconButton(onPressed: (){
               _getDateFromUser(isStartDate: false);
               }, icon: Icon(Icons.calendar_today_outlined,color: grey,),iconSize: 20,),),
             ),
           ],
         ),
         Row(
          children: [
            Expanded(child: InputField(title: "Start Time", hint: _startTime, controller: TextEditingController(),widget: IconButton(onPressed: (){
              _getTimeFromUser(isStartTime: true);
         }, icon: Icon(Icons.access_time_outlined,color: grey,),iconSize: 20,),),),
         SizedBox(
          width: 12.0,
         ),
          Expanded(child: InputField(title: "End Time", hint: _endTime, controller: TextEditingController(),widget: IconButton(onPressed: (){
            _getTimeFromUser(isStartTime: false);
         }, icon: Icon(Icons.access_time_outlined,color: grey,),iconSize: 20,),),)
          ],
         ),
         InputField(title: "Remind", hint: "$_selectedRemind minutes early", controller: TextEditingController(),
         widget: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down,color: grey,size: 20,),
          elevation: 4,
          style: subTitleStyle,
          underline: Container(
            height: 0,
          ),
          items: remindList.map<DropdownMenuItem<String>>((int value){
            return DropdownMenuItem<String>(
              value: value.toString(),
              child: Text(value.toString()));
          }).toList(), onChanged:(String? newValue){
            setState(() {
              _selectedRemind= int.parse(newValue!);
            });
          } ),
         ),
           InputField(title: "Repeat", hint: _selectedRepeat, controller: TextEditingController(),
         widget: DropdownButton(
          icon: Icon(Icons.keyboard_arrow_down,color: grey,size: 20,),
          elevation: 4,
          style: subTitleStyle,
          underline: Container(
            height: 0,
          ),
          items: repeatList.map<DropdownMenuItem<String>>((String value){
            return DropdownMenuItem<String>(
              value: value.toString(),
              child: Text(value.toString(),style: TextStyle(color: grey),));
          }).toList(), onChanged:(String? newValue){
            setState(() {
              _selectedRepeat= newValue!;
            });
          } ),
         ),
         Container(
           margin: EdgeInsets.only(top: 16.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _colorPallete(),
              ZitharaButton(label: "Create Task", onTap: ()=>_validateDate())
            ],
           ),
         )
      ],
    ),
  ),
),
      ));
  }

_validateDate(){
if(_titleController.text.isNotEmpty&&_descriptionController.text.isNotEmpty){
  //add to database
  _addTaskToDB();
  Get.back();
}else if (_titleController.text.isEmpty || _descriptionController.text.isEmpty){
Get.snackbar("Required", "All fields are required !",
snackPosition: SnackPosition.BOTTOM,
backgroundColor: white,
colorText: pinkClr,
icon: Icon(Icons.warning_amber_rounded)
);
}
}

_addTaskToDB()async{
int value= await _taskController.addTask(task: 
  Task(
    description:_descriptionController.text,
    title: _titleController.text,
    startDate: DateFormat.yMd().format(_startDate),
     endDate: DateFormat.yMd().format(_endDate),
    startTime: _startTime,
    endTime: _endTime,
    remind: _selectedRemind,
    repeat: _selectedRepeat,
    color: _selectedColor,
    isCompleted: 0
  ));

}

_colorPallete(){
  return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Color",style: titleStyle,),
                  SizedBox(
                    height: 8.0,
                  ),
                  Wrap(
                    children:List<Widget>.generate(
                     3, (index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            _selectedColor=index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right:8.0,),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: index==0?primaryClr:index==1?pinkClr:yellowClr,
                            child:index==_selectedColor? Icon(Icons.done,color: white,size: 16,):null,
                          ),
                        ),
                      );
                     }
                    )
                  )
                ],
              );
}

_appBar(BuildContext context){
  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.scaffoldBackgroundColor,
    leading: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Icon(Icons.arrow_back_ios,size: 20,color: Get.isDarkMode?Colors.white:Colors.black,),
    ),
    actions:const [
     CircleAvatar(
      backgroundImage: NetworkImage("https://th.bing.com/th/id/OIP.BXIDxWxdAz3nDz0d1tUizQHaE8?w=227&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
     ),
      SizedBox(
        width: 20.0,
      ),
    ],
  );

}

_getDateFromUser({required bool isStartDate})async{
  DateTime? _pickerDate =await showDatePicker(context: context,initialDate: DateTime.now(), firstDate: DateTime(2015), lastDate: DateTime(2100));

  if(_pickerDate==null){
  }else if(isStartDate==true){
    setState(() {
       _startDate=_pickerDate;
    });
   
  }else if(isStartDate==false){
    setState(() {
       _endDate=_pickerDate;
    });
    }
  else{
   
  }
}

_getTimeFromUser({required bool isStartTime}) async{
var pickedTime =await _showTimePicker();
String _formatedTime = pickedTime.format(context);
if(pickedTime==null){
  
}else if(isStartTime==true){
  setState(() {
    _startTime = _formatedTime;
  });
  
}else if (isStartTime==false) {
  setState(() {
    _endTime = _formatedTime;
  });

}
}

_showTimePicker(){
  return showTimePicker(
    initialEntryMode: TimePickerEntryMode.dial,
    context: context, initialTime: TimeOfDay(
      //_startTime -->10:30 AM
      hour: int.parse(_startTime.split(":")[0]),
       minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
}

}