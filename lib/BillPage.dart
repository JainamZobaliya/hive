import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/DrawerPage.dart';
import 'package:hive/UserProfile.dart';

class BillPage extends StatefulWidget {
  static const routeName = '/BillPage';
  UserProfile user;
  BillPage({this.user});
  @override
  _BillPageState createState() => _BillPageState();
}

UserProfile loadData(String uid) {
  UserProfile me = UserProfile(userId: uid);
  return me;
}

class _BillPageState extends State<BillPage> {
  UserProfile me;
  @override
  Widget build(BuildContext context) {
    print("In BillPage");
    me = widget.user;
    print("${me.userId}");
    // Future.delayed(Duration(seconds: 5), () => {me = loadData(widget.uid)});
    return Scaffold(
        backgroundColor: Color(0xFF123c69),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF123c69)),
          title: Text(
            'Bill Receipt',
            style: TextStyle(
                color: Color(0xFF123c69), fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFFD2FDFF),
        ),
        drawer: DrawerPage(
          me: me,
        ),
        drawerEnableOpenDragGesture: true,
        drawerEdgeDragWidth: MediaQuery.of(context).size.width / 4,
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 100,
                  child: Container(
                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/as.png'),
                      radius: 60.0,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 50),
                Text(
                  "Amount: \u{20B9} 200/-",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFD2FDFF),
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Expanded(
              child: Divider(
                height: 20,
                color: Color(0xFFD2FDFF),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    " Pick Up: Vashi",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFFD2FDFF),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Drop: Andheri",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFFD2FDFF),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Vehicle: Prime Sedan",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFFD2FDFF),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Divider(
                height: 20,
                color: Color(0xFFD2FDFF),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                "How was your Ride ?",
                style: TextStyle(
                    fontSize: 25.0,
                    color: Color(0xFFD2FDFF),
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            )
          ]),
        )));
  }
}
