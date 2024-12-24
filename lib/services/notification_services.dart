import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:zithara_task_manager/models/task.dart';
import 'package:zithara_task_manager/ui/notified_page.dart';

class NotificationServices extends GetxService{
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  RxInt notificationId = 0.obs;
@override
  void onInit() async {
    tz.initializeTimeZones();
    initNotification();
    super.onInit();
  }

Future<void> initNotification() async{
  _configureLocalTimeZone();
  AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('appicon');

  var initializationSettingsIOS = DarwinInitializationSettings(
requestAlertPermission: true,
requestBadgePermission: true,
requestSoundPermission: true,
  );

var initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  iOS: initializationSettingsIOS,
);

await notificationsPlugin.initialize(initializationSettings,
onDidReceiveNotificationResponse: (NotificationResponse notificationResponse)async{
selectNotification(notificationResponse.payload);
}
);






}

 Future selectNotification(String? payload) async {
      if(payload=="Theme Changed"){
       
      }else{
        
            Get.to(()=>NotifiedPage(label:payload));
     
      }
  }

notificationDetails(){
  return  NotificationDetails(
    android: AndroidNotificationDetails("channelId", "channelName",priority: Priority.high,importance: Importance.max,playSound: true,enableLights: true),
    iOS: DarwinNotificationDetails()
  );
}

 Future shownotification({
    // int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    notificationId.value = notificationId.value + 1;
    notificationId.refresh();
    notificationsPlugin.show(int.parse(DateTime.now().millisecond.toString()), title,
        body, await (notificationDetails()),
        payload: payload,);
  }

  scheduledNotification(DateTime scheduledNotificationDateTime,Task task)async{
    await notificationsPlugin.zonedSchedule(task.id!, task.title, task.description,
   tz.TZDateTime.from(
scheduledNotificationDateTime,tz.local
   )
    , NotificationDetails(
      android: AndroidNotificationDetails('your channel id', 'your channel name',channelDescription: 'your channel description')

    ),
    matchDateTimeComponents: DateTimeComponents.time, 
    payload: "${task.title??""}|${task.description??""}",
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

//   tz.TZDateTime _convertTime(int hour, int minutes){
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minutes);
// if(scheduleDate.isBefore(now)){
//   scheduleDate = scheduleDate.add(const Duration(days: 1));
// }
//     return scheduleDate;
//   }

_configureLocalTimeZone()async{
  try{
  tz.initializeTimeZones();

  // final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
  // tz.setLocalLocation(tz.getLocation(timeZone));
}
catch(e){
  if (kDebugMode) {
    print('Could not get the local timezone');
  }
}
}

}