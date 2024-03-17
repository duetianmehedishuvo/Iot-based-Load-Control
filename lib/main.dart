import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/provider/auth_provider.dart';
import 'package:women_safety/screen/splash_screen.dart';
import 'package:women_safety/util/helper.dart';
import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAGDClS7C4rYoVs77kDlcs5gPLPL-_7nNw",
      appId: "1:25337127069:android:df4d0b0c79625c4f447474",
      messagingSenderId: "25337127069",
      projectId: "solar-power-aerator-for-79b02",
    ),
  );


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Load Control',
      navigatorKey: Helper.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(),
    );
  }
}
