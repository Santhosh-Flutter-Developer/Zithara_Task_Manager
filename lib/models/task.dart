class Task {
  int? id;
  String? title;
  String? description;

  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  int? isCompleted;

Task({
  this.id,
  this.title,
  this.description,
  this.startDate,
  this.endDate,
  this.startTime,
  this.endTime,
  this.color,
  this.remind,
  this.repeat,
  this.isCompleted,
});

Task.fromJson(Map<String, dynamic> json){
id =json["id"];
title=json["title"];
description=json["description"];
startDate=json["startDate"];
endDate=json["endDate"];
startTime=json["startTime"];
endTime=json["endTime"];
color=json["color"];
remind=json["remind"];
repeat=json["repeat"];
isCompleted=json["isCompleted"];
}

Map<String, dynamic> toJson(){
  final Map<String,dynamic> data = <String,dynamic>{};
  data['id']=this.id;
  data['title']=this.title;
  data['description']=this.description;
   data['startDate']=this.startDate;
  data["endDate"]=this.endDate;
 
  data['startTime']=this.startTime;
  data['endTime']=this.endTime;
  data['color']=this.color;
  data['remind']=this.remind;
  data['repeat']=this.repeat;
   data['isCompleted']=this.isCompleted;
  return data;
}

}