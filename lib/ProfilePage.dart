import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/DrawerPage.dart';
import 'package:hive/UserProfile.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfilePage';
  UserProfile user;
  ProfilePage({this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile me;

  UserProfile loadData(String uid) {
    UserProfile me = widget.user;
    return me;
  }
// @override
//   void initState() {
//     Future.delayed(Duration(seconds: 5), () => {me = loadData(widget.uid)});
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    print("In ProfilePage");
    me = widget.user;
    print("${me.userId}");
    return Container(
      color: Color(0xFFD2FDFF),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('Profile',
                style: TextStyle(
                  color: Color(0xFF123c69),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            backgroundColor: Color(0xFFD2FDFF),
            expandedHeight: 250.0,
            iconTheme: IconThemeData(color: Color(0xFF123c69)),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('images/as.png', fit: BoxFit.cover),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 150.0,
            delegate: SliverChildListDelegate(
              [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF123c69),
                  shadowColor: Color(0xFF123c69),
                  elevation: 20,
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("Name: ",
                            style: TextStyle(
                              color: Color(0xFFD2FDFF),
                              fontSize: 20.0,
                            )),
                        Text(" ${me.fullName}",
                            style: TextStyle(
                              color: Color(0xFFD2FDFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF123c69),
                  shadowColor: Color(0xFF123c69),
                  elevation: 20,
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("Email Id.: ",
                            style: TextStyle(
                              color: Color(0xFFD2FDFF),
                              fontSize: 20.0,
                            )),
                        Text(" ${me.emailId}",
                            style: TextStyle(
                              color: Color(0xFFD2FDFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFF123c69),
                  shadowColor: Color(0xFF123c69),
                  elevation: 20,
                  child: Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text("Mobile No.: ",
                            style: TextStyle(
                              color: Color(0xFFD2FDFF),
                              fontSize: 20.0,
                            )),
                        Text(" ${me.mobileNo}",
                            style: TextStyle(
                              color: Color(0xFFD2FDFF),
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFF123c69),
                        shadowColor: Color(0xFF123c69),
                        elevation: 20,
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text("Gender: ",
                                  style: TextStyle(
                                    color: Color(0xFFD2FDFF),
                                    fontSize: 20.0,
                                  )),
                              Text(" ${me.gender}",
                                  style: TextStyle(
                                    color: Color(0xFFD2FDFF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Color(0xFF123c69),
                        shadowColor: Color(0xFF123c69),
                        elevation: 20,
                        child: Container(
                          height: 100,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text("Age: ",
                                  style: TextStyle(
                                    color: Color(0xFFD2FDFF),
                                    fontSize: 20.0,
                                  )),
                              Text(" ${me.age}",
                                  style: TextStyle(
                                    color: Color(0xFFD2FDFF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
    // MaterialApp(
    //     home: Scaffold(
    //   backgroundColor: Color(0xFFD2FDFF),
    //   drawer: DrawerPage(
    //     me: me,
    //   ),
    //   drawerEnableOpenDragGesture: true,
    //   drawerEdgeDragWidth: MediaQuery.of(context).size.width / 4,
    //   body: CustomScrollView(
    //         slivers: <Widget>[Column(
    //       children: <Widget>[
    //         SliverAppBar(
    //           leading: IconButton(
    //               icon: Icon(Icons.filter_1),
    //               onPressed: () {
    //                 // Do something
    //               }),
    //           expandedHeight: 220.0,
    //           floating: true,
    //           // pinned: true,
    //           // snap: true,
    //           elevation: 50,
    //           backgroundColor: Color(0xFFD2FDFF),
    //           flexibleSpace: FlexibleSpaceBar(
    //               centerTitle: true,
    //               title: Text('Profile',
    //                   style: TextStyle(
    //                     color: Color(0xFF123c69),
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 16.0,
    //                   )),
    //               background: Image.asset(
    //                 'images/as.png',
    //                 fit: BoxFit.cover,
    //               )),
    //         ),
    //         new SliverList(
    //           delegate: new SliverChildListDelegate(_buildList()),
    //         ),
    //       ],
    //     ),
    //         ],
    //   ),
    // ),);
  }

  Widget profile() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Row(
            children: [
              Text("Name: ",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontSize: 16.0,
                  )),
              Text(" ${me.fullName}",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text("Email Id.: ",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontSize: 16.0,
                  )),
              Text(" ${me.emailId}",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text("Mobile No.: ",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontSize: 16.0,
                  )),
              Text(" ${me.mobileNo}",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text("Gender: ",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontSize: 16.0,
                  )),
              Text(" ${me.gender}",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text("Age: ",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontSize: 16.0,
                  )),
              Text(" ${me.age}",
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
  // initState();
  //   return Scaffold(
  //       backgroundColor: Colors.teal,
  //       appBar: AppBar(
  //         title: Text('Profile'),
  //         backgroundColor: Colors.black,
  //       ),
  //       drawer: DrawerPage(me: me,),
  //       drawerEnableOpenDragGesture: true,
  //       drawerEdgeDragWidth: MediaQuery.of(context).size.width / 4,
  //       body: SafeArea(
  //         child: Column(
  //           children: [
  //             Container(
  //               decoration: new BoxDecoration(color: Colors.teal),
  //               child: Container(
  //                 width: double.infinity,
  //                 height: 150,
  //                 child: Container(
  //                   alignment: Alignment(0.0,2.5),
  //                   child: CircleAvatar(
  //                     backgroundImage: AssetImage('images/as.png'),
  //                     radius: 60.0,
  //                     ),
  //                   ),
  //                 ),
  //               ),

  //             SizedBox(
  //               height: 60,
  //             ),
  //             Text(
  //               "${me.fullName}"
  //               ,style: TextStyle(
  //                 fontSize: 25.0,
  //                 color:Colors.black,
  //                 letterSpacing: 2.0,
  //                 fontWeight: FontWeight.w400
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               "${me.emailId}"
  //               ,style: TextStyle(
  //                 fontSize: 18.0,
  //                 color:Colors.black,
  //                 letterSpacing: 2.0,
  //                 fontWeight: FontWeight.w300
  //             ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               "${me.mobileNo}"
  //               ,style: TextStyle(
  //                 fontSize: 15.0,
  //                 color:Colors.black,
  //                 letterSpacing: 2.0,
  //                 fontWeight: FontWeight.w300
  //             ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               "${me.age}, ${me.gender}"
  //               ,style: TextStyle(
  //                 fontSize: 18.0,
  //                 color:Colors.black,
  //                 letterSpacing: 2.0,
  //                 fontWeight: FontWeight.w300
  //             ),
  //             ),
  //             SizedBox(
  //               height: 30,
  //             ),
  //             Card(
  //               margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Expanded(
  //                       child: Column(
  //                         children: [
  //                           Text("Rides",
  //                             style: TextStyle(
  //                                 color: Colors.black,
  //                                 fontSize: 22.0,
  //                                 fontWeight: FontWeight.w600
  //                             ),),
  //                           SizedBox(
  //                             height: 7,
  //                           ),
  //                           Text("15",
  //                             style: TextStyle(
  //                                 color: Colors.teal,
  //                                 fontSize: 22.0,
  //                                 fontWeight: FontWeight.w300
  //                             ),)
  //                         ],
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child:
  //                       Column(
  //                         children: [
  //                           Text("Kms Travelled",
  //                             style: TextStyle(
  //                                 color: Colors.black,
  //                                 fontSize: 22.0,
  //                                 fontWeight: FontWeight.w600
  //                             ),),
  //                           SizedBox(
  //                             height: 7,
  //                           ),
  //                           Text("200",
  //                             style: TextStyle(
  //                                 color: Colors.teal,
  //                                 fontSize: 22.0,
  //                                 fontWeight: FontWeight.w300
  //                             ),)
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 50,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 RaisedButton(
  //                   onPressed: (){

  //                   },
  //                   shape:  RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(80.0),
  //                   ),
  //                   child: Ink(
  //                     decoration: BoxDecoration(
  //                       gradient: LinearGradient(
  //                           begin: Alignment.centerLeft,
  //                           end: Alignment.centerRight,
  //                           colors: [Colors.black,Colors.teal]
  //                       ),
  //                       borderRadius: BorderRadius.circular(30.0),

  //                     ),
  //                     child: Container(
  //                       constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "Contact Us",
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 12.0,
  //                             letterSpacing: 2.0,
  //                             fontWeight: FontWeight.w300
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 RaisedButton(
  //                   onPressed: (){

  //                   },
  //                   shape:  RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(80.0),
  //                   ),
  //                   child: Ink(
  //                     decoration: BoxDecoration(
  //                       gradient: LinearGradient(
  //                           begin: Alignment.centerLeft,
  //                           end: Alignment.centerRight,
  //                           colors: [Colors.black,Colors.teal]
  //                       ),
  //                       borderRadius: BorderRadius.circular(80.0),

  //                     ),
  //                     child: Container(
  //                       constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         "About Us",
  //                         style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 12.0,
  //                             letterSpacing: 2.0,
  //                             fontWeight: FontWeight.w300
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             )
  //           ],
  //         ),
  //       )
  //   );
  // }
}
