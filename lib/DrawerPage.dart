import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/LogInPage.dart';
import 'package:hive/ProfilePage.dart';
import 'package:hive/UserProfile.dart';

class DrawerPage extends StatelessWidget {
  DrawerPage({this.me});
  UserProfile me;
  @override
  Widget build(BuildContext context) {
    print("In Drawerpage uid is: ${me.userId}");
    return Drawer(
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0xFF123c69),
                child: DrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/logo.png"),
                          fit: BoxFit.fitWidth)),
                  child: Text(""),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: <Widget>[
                  Container(
                    color: Color(0xFF123c69),
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF123c69),
                    ),
                    title: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    selectedTileColor: Color(0xFF64DFDF),
                    tileColor: Color(0xFF64DFDF),
                    onTap: () {
                      onLoading(context, me, ProfilePage);
                    },
                  ),
                  Container(
                    color: Color(0xFF123c69),
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      size: 40,
                      color: Color(0xFF123c69),
                    ),
                    title: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    selectedTileColor: Color(0xFF64DFDF),
                    tileColor: Color(0xFF64DFDF),
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   Settings.routeName,);
                    },
                  ),
                  Container(
                    color: Color(0xFF123c69),
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      size: 40,
                      color: Color(0xFF123c69),
                    ),
                    title: Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    selectedTileColor: Color(0xFF64DFDF),
                    tileColor: Color(0xFF64DFDF),
                    onTap: () async {
                      // // me.signOut();
                        await me.auth.signOut();
                      //   Intent i=new Intent(getApplicationContext(),LoginActivity.class);
                      //   startActivity(i);

                      Navigator.pushNamed(
                        context,
                        LogInPage.routeName,
                      );
                    },
                  ),
                  Container(
                    color: Color(0xFF123c69),
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onLoading(BuildContext context, UserProfile me, var page) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xFFD2FDFF)),
                ),
                new Text(
                  "Loading",
                  style: TextStyle(
                      color: Color(0xFFD2FDFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(
        new Duration(seconds: 3),
        () => {
              Navigator.pop(context), //pop dialog
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return ProfilePage(
                  user: me,
                );
              })),
            });
  }
}
