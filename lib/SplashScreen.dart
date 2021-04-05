import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/HomePage.dart';
import 'package:hive/LogInPage.dart';
import 'package:hive/UserProfile.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splashPage';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoading = true;
  //creating the timer that stops the loading after 15 secs
  void startTimer() {
    Timer.periodic(const Duration(seconds: 5), (t) {
      setState(() {
        isLoading = false; //set loading to false
      });
      t.cancel(); //stops the timer
    });
  }

  @override
  void initState() {
    startTimer(); //start the timer on loading
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // User result = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Color(0xFF64DFDF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            background(),
            isLoading
                ? CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Color(0xFF123c69)),
                  )
                : _checker(),
          ],
        ),
      ),
    );
  }

  _checker() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return LogInPage();
        }));
      } else {
        var userId = user.uid;
        UserProfile me = new UserProfile(userId: userId);
        print('User is signed in!');
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return HomePage(
            user: me,
          );
        }));
      }
    });
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF123c69)),
    );
  }

  background() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: Image.asset('images/logo.png', fit: BoxFit.fitWidth, height: 150),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(50.0),
        border: Border.all(color: Color(0xFF123c69), width: 15.0),
        color: Color(0xFFD2FDFF),
      ),
    );
  }
}
