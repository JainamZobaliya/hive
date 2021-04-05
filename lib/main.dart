import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/BillPage.dart';
import 'package:hive/HomePage.dart';
import 'package:hive/ProfilePage.dart';
import 'package:hive/SplashScreen.dart';
import 'package:hive/LogInPage.dart';
import 'package:hive/RegistrationPage.dart';
import 'package:hive/blocs/application_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HiVe());
}

class HiVe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        initialRoute: SplashPage.routeName,
        title: "HiVe - Hire Vehicle",
        routes: {
          SplashPage.routeName: (BuildContext context) => SplashPage(),
          LogInPage.routeName: (BuildContext context) => LogInPage(),
          RegistrationPage.routeName: (BuildContext context) =>
              RegistrationPage(),
          HomePage.routeName: (BuildContext context) => HomePage(),
          BillPage.routeName: (BuildContext context) => BillPage(),
          ProfilePage.routeName: (BuildContext context) => ProfilePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
