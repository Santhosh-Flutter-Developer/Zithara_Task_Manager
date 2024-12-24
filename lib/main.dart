import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zithara_task_manager/db/db_helper.dart';
import 'package:zithara_task_manager/services/notification_services.dart';
import 'package:zithara_task_manager/services/theme_services.dart';
import 'package:zithara_task_manager/ui/login_page.dart';
import 'package:zithara_task_manager/ui/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  await GetStorage.init();
  tz.initializeTimeZones();
  if (!GetPlatform.isWeb) {
    await Get.putAsync<NotificationServices>(() async => NotificationServices());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zithara Task Manager',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      themeMode: ThemeServices().theme,
     darkTheme: Themes.dark,
      home: LoginPage(),
    );
  }
}
