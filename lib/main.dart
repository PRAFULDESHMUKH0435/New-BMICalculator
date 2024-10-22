import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'Hive/UserData.dart';
import 'Screens/HomeScreen.dart';
import 'Providers/HomeScreenProvider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{

  /// Firebase Initialization
  WidgetsFlutterBinding.ensureInitialized();

  await (MobileAds.instance.initialize());

  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBZsvFhji4-YWUwFfnALzVBbkcMEoheS4k",		// Current Key    (App Level googleservices.json)
      appId: "1:1577961264:android:e82ace01cb738f6f47aaf5", // mobilesdk_app_id  (App Level googleservices.json)
      messagingSenderId: "1577961264",					            // project_number	 (App Level googleservices.json)
      projectId: "bmi-calculator-a3ddc",						        // project_id     (App Level googleservices.json)
    ),
  ): await Firebase.initializeApp();


  /// OneSignal Initialization
  OneSignal.initialize("f03a0986-0aac-4751-b89a-3e5c6dad637a");
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Notifications.requestPermission(true);


  /// Hive Initialization
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserDataAdapter());
  await Hive.openBox("BMIHistory");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>HomeScreenProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
