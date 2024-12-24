import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:zithara_task_manager/controllers/task_controller.dart';
import 'package:zithara_task_manager/models/task.dart';
import 'package:zithara_task_manager/services/notification_services.dart';
import 'package:zithara_task_manager/services/theme_services.dart';
import 'package:zithara_task_manager/ui/add_task.dart';
import 'package:zithara_task_manager/ui/theme.dart';
import 'package:zithara_task_manager/ui/widgets/button.dart';
import 'package:zithara_task_manager/ui/widgets/input_field.dart';
import 'package:zithara_task_manager/ui/widgets/task_tile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  String _selectedSort = "Due Date";
  List<String> sortList =[
    "Due Date",
     "Title",
    
  ];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: false,
      child: Scaffold(
        appBar: _appBar(),
        body: RefreshIndicator(
          onRefresh: ()async{
            await Future.delayed(const Duration(seconds: 1),);
            _taskController.getTasks();
          },
          child:Obx(()=>_taskController.loader.value?Center(child: CircularProgressIndicator(
            color: bluishClr,
          )): Column(
            children: [
              _addTaskBar(),
              _addDateBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     SizedBox(
                      width: 154,
                       child: InputField(title: "", hint: _selectedSort, controller: TextEditingController(),
                                widget: DropdownButton(
                                 icon: Icon(Icons.keyboard_arrow_down,color: grey,size: 20,),
                                 elevation: 4,
                                 style: subTitleStyle,
                                 underline: Container(
                                   height: 0,
                                 ),
                                 items: sortList.map<DropdownMenuItem<String>>((String value){
                                   return DropdownMenuItem<String>(
                                     value: value.toString(),
                                     child: Text(value.toString(),style: TextStyle(color: grey),));
                                 }).toList(), onChanged:(String? newValue){
                                   setState(() {
                                     _selectedSort= newValue!;
                                     if(_taskController.taskList.length>1){
                                     if(_selectedSort=="Due Date"){
                                     _taskController.taskList= _taskController.taskList..sort((item1,item2)=>item2.endDate.toString().compareTo(item1.endDate.toString()));
                                     _taskController.taskList.refresh();
                                
                                     }else{
                                       _taskController.taskList= _taskController.taskList..sort((item1,item2)=>item2.title.toString().compareTo(item1.title.toString()));
                                       _taskController.taskList.refresh();
                                    
                                     }}
                                   });
                                 } ),
                                ),
                     ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: Text(_taskController.completed.value?"Completed":"In progress")),
                        Switch(value: _taskController.completed.value, onChanged: (val){
                          _taskController.completed.value=!_taskController.completed.value;
                          _taskController.completed.refresh();
                          if(_taskController.completed.value){
                        _taskController.taskList.value=  _taskController.taskList.where((element)=>element.isCompleted.toString()=="1").toList();
                        }else{
                          _taskController.getTasks(load: false);
                        }
                        },
                        activeColor: bluishClr,
                        ),
                      ],
                    )
                  ],
                ),
              ),
             SizedBox(
              height: 20,
             ),
              _showTasks(),
            ],
          )),
        ),
      ),
    );
  }

_showTasks(){
  return Expanded(child:Obx(()=> ListView.builder(
    itemCount: _taskController.taskList.length,
    itemBuilder: (_,index){
      Task task =_taskController.taskList[index];
      if(task.repeat=="Daily"){
//         RegExp formatWithLeadingZero = RegExp(r"^0\d:\d{2}$"); // Matches 02:00 format
//   RegExp formatWithoutLeadingZero = RegExp(r"^\d:\d{2}$"); // Matches 2:00 format

//  DateFormat inputFormat = DateFormat("h:mm");
//     DateFormat outputFormat = DateFormat("HH:mm");
//      DateTime time = inputFormat.parse(task.startTime.toString());
//     String formattedTime = outputFormat.format(time);
//         DateTime date = DateFormat.jm().parse(formattedTime.toString());
//         print("date:$date");
//         var myTime= DateFormat("HH:mm").format(date);
//         NotificationServices().scheduledNotification(
//           date,
//            task
//         );
        return AnimationConfiguration.staggeredList(position: index, child: SlideAnimation(child: FadeInAnimation(child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
             _showBottomSheet(context,task);
            },
            child: TaskTile(task: task),
          ),
        )
      ],
    ))));
      }
      if(task.startDate==DateFormat.yMd().format(_selectedDate)){
return AnimationConfiguration.staggeredList(position: index, child: SlideAnimation(child: FadeInAnimation(child: Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
             _showBottomSheet(context,task);
            },
            child: TaskTile(task: task),
          ),
        )
      ],
    ))));
      }else{
        return Container(
        );
      }
    
  })) );
}


_showBottomSheet(BuildContext context,Task task){
 Get.bottomSheet(Container(
  padding: const EdgeInsets.only(
    top: 4.0
  ),
  height: task.isCompleted==1?MediaQuery.of(context).size.height*0.24:MediaQuery.of(context).size.height*0.32,
  color: Get.isDarkMode? darkGreyClr:white,
  child: Column(
    children: [
      Container(
        height: 6,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
        ),
      ),
      Spacer(),
      task.isCompleted==1?SizedBox():_bottomSheetButton(label: "Task Completed", onTap: (){
        _taskController.markTaskCompleted(task.id!);
        Get.back();
      }, clr: primaryClr,
      context:context
      ),
       _bottomSheetButton(label: "Delete Task", onTap: (){
         _taskController.delete(task);
        Get.back();
      }, clr:Colors.red[300]!,
      context:context
      ),
      SizedBox(
        height: 20,
      ),
      _bottomSheetButton(label: "Close", onTap: (){
        Get.back();
      },
      isClose: true,
       clr:Colors.red[300]!,
      context:context
      )
    ],
  ),
 )); 
}

_bottomSheetButton({
  required String label,
  required Function()? onTap,
  required Color clr,
  bool isClose=false,
  required BuildContext context,
}){
return GestureDetector(
  onTap: onTap,
  child: Container(
    margin: const EdgeInsets.symmetric(
      vertical: 4.0
    ),
    height: 55,
    width: MediaQuery.of(context).size.width*0.9,
   
    decoration: BoxDecoration(
      border: Border.all(
        width: 2,
        color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr
      ),
        color: isClose==true?Colors.transparent:clr,
      borderRadius: BorderRadius.circular(20.0)
    ),
    child: Center(child: Text(label,style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),)),
  ),
);
}
_addDateBar(){
  return Container(
              margin: EdgeInsets.only(top: 20.0,left: 20.0),
              child: DatePicker(
                DateTime(2024,12,23),
                height:100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: primaryClr,
                selectedTextColor: white,
                dateTextStyle: GoogleFonts.lato(
                 textStyle:  TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: grey
                ),
                
                ),
                 dayTextStyle: GoogleFonts.lato(
                 textStyle:  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: grey
                )),
                 monthTextStyle: GoogleFonts.lato(
                 textStyle:  TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: grey
                )),
                onDateChange: (date){
                  setState(() {
                    _selectedDate=date;
                  });
                },
              ),
            );
}
_addTaskBar(){
  return Container(
              margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMMMMd().format(DateTime.now()),style: subHeadingStyle,),
                        Text("Today",style: headingStyle,)
                      ],
                    ),
                  
                  ZitharaButton(label: "+ Add Task", onTap: ()async{
                   await Get.to(AddTask());
                   _taskController.getTasks();
                  })
                ],
              ),
            );
}

_appBar(){
  return AppBar(
    elevation: 0,
    backgroundColor: context.theme.scaffoldBackgroundColor,
    leading: GestureDetector(
      onTap: (){
        ThemeServices().switchTheme();
        NotificationServices().shownotification(
          title:"Theme Changed",
          body:Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme",
          payload: "Theme Changed"
        );
       
      },
      child: Icon(Get.isDarkMode?Icons.wb_sunny_outlined: Icons.nightlight_round,size: 20,color: Get.isDarkMode?Colors.white:Colors.black,),
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


}