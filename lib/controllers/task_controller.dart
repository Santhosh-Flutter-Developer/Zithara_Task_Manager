
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:zithara_task_manager/db/db_helper.dart';
import 'package:zithara_task_manager/models/task.dart';

class TaskController extends GetxController{
var taskList = <Task>[].obs;
RxBool loader =false.obs;
RxBool completed = false.obs;

  @override
  void onInit(){
    super.onInit();
    getTasks();
  }


Future<int> addTask({Task? task})async{
  return await DbHelper.insert(task);
}

void getTasks({bool? load=true}) async {
  try{
    if(load==true){
    loader(true);}
  List<Map<String, dynamic>> tasks = await DbHelper.query();
  taskList.assignAll(tasks.map((data)=> Task.fromJson(data)).toList());
  }catch(e){
    if (kDebugMode) {
      print(e);
    }

  }
  Future.delayed(Duration(seconds: 1),(){
  loader(false);
  });
 
}

void delete(Task task){
 DbHelper.delete(task);
 getTasks();
}

void markTaskCompleted(int id)async{
 await DbHelper.update(id);
 getTasks();
}

}