import 'package:berty1/accountss.dart';
import 'package:berty1/splash.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("c5d8a813-795c-4724-a8c0-e545a050e0f5");
  OneSignal.Notifications.requestPermission(true);

  fetchData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          '/homePage': (context) => MyWidget(),
          '/signUpPage': (context) => ProfilePage(),
        });
  }
}
