import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieapp/models/items_model.dart';
import 'package:movieapp/models/user_model.dart';
import 'package:movieapp/screens/authenticate_screen.dart';
import 'package:movieapp/services/auth_wrapper.dart';
import 'package:movieapp/services/authentication.dart';
import 'package:sqflite/sqflite.dart';
import './screens/home_screen.dart';
import './models/ticket_model.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './services/local_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => TicketModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => ItemProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserModel(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light));

    return MaterialApp(
        title: 'EmeraldMovies',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Color(0xFF00660D),
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamProvider<LocalUser>.value(
          value: AuthService().user,
          child: Wrapper(),
        ));
  }
}
