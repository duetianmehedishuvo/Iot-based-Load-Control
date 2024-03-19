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
      apiKey: "AIzaSyBK3ydAm1tylYxUwo8DwJQYTpJ4f5TXboc",
      appId: "1:57443790135:android:315b81a2513d203fa67eb2",
      messagingSenderId: "57443790135",
      projectId: "ac-control-33921",
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
      title: 'AC Control',
      navigatorKey: Helper.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const SplashScreen(),
    );
  }
}
