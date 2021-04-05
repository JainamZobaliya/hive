import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/BillPage.dart';
import 'package:hive/DrawerPage.dart';
import 'package:hive/UserProfile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'dart:async';
import 'package:google_maps_webservice/places.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomeeeePage';
  UserProfile user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserProfile me;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final _pickUp = TextEditingController();
  final _destination = TextEditingController();
  static const kGoogleApiKey = "AIzaSyCxmVZiaqmJZnrmPZPgGAhLgKI46weWqVA";

  @override
  Widget build(BuildContext context) {
    print("In HomePage");
    me = widget.user;
    me.auth = FirebaseAuth.instance;
    print("${me.userId}");
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    // Future.delayed(Duration(seconds: 5), () => {me = loadData(widget.uid)});
    return Scaffold(
      backgroundColor: Color(0xFF123c69),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF123c69)),
        title: Text(
          'HiVe - Hire Vehicle',
          style:
              TextStyle(color: Color(0xFF123c69), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFFD2FDFF),
      ),
      drawer: DrawerPage(
        me: me,
      ),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 4,
      body: // (applicationBloc.currentLocation==null)? loader(context) :
          Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            getMap(applicationBloc),
            Container(
              padding: EdgeInsets.all(10),
              margin:EdgeInsets.all(20),
              child: TextField(
                style: TextStyle(
                  color: Color(0xFF123c69),
                  fontFamily: 'Times New Roman',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                  labelText: 'Enter Pick-up Point',
                  labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123c69),
                  ),
                  focusColor: Color(0xFF123c69),
                  prefixIcon: Icon(Icons.location_on_outlined, color: Color(0xFF123c69)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF123c69)),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
                controller: _pickUp,
                onTap: () async {
                  // then get the Prediction selected
                  // Prediction p = await PlacesAutocomplete.show(
                  //     context: context, apiKey: kGoogleApiKey);
                  // SSSdisplayPrediction(p);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin:EdgeInsets.fromLTRB(20,100,20,20),
              child: TextField(
                style: TextStyle(
                  color: Color(0xFF123c69),
                  fontFamily: 'Times New Roman',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                  labelText: 'Enter Destination Point',
                  labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123c69),
                  ),
                  focusColor: Color(0xFF123c69),
                  prefixIcon: Icon(Icons.location_on, color: Color(0xFF123c69)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF123c69)),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
                controller: _destination,
                onTap: () async {
                  // then get the Prediction selected
                  // Prediction p = await PlacesAutocomplete.show(
                  //     context: context, apiKey: kGoogleApiKey);
                  // SSSdisplayPrediction(p);
                },
              ),
            ),
            _pickUp.text != "" && _destination.text != ""
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              InkWell(
                                splashColor: Color(0xFF123c69),
                                radius: MediaQuery.of(context).size.width / 2,
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return BillPage(
                                      user: me,
                                    );
                                  }));
                                },
                                child: Card(
                                  color: Color(0xFFD2FDFF),
                                  shadowColor: Color(0xFF123c69),
                                  elevation: 20,
                                  margin: EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD2FDFF),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.bike_scooter,
                                            size: 40, color: Color(0xFF123c69)),
                                        Text(
                                          "Bicycle",
                                          style: TextStyle(
                                            color: Color(0xFF123c69),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "\u{20B9} 80/-",
                                          style: TextStyle(
                                            color: Color(0xFF123c69),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Color(0xFF123c69),
                                radius: MediaQuery.of(context).size.width / 2,
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return BillPage(
                                      user: me,
                                    );
                                  }));
                                },
                                child: Card(
                                  color: Color(0xFFD2FDFF),
                                  shadowColor: Color(0xFF123c69),
                                  elevation: 20,
                                  margin: EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD2FDFF),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.motorcycle,
                                            size: 40, color: Color(0xFF123c69)),
                                        Text(
                                          "Bike",
                                          style: TextStyle(
                                            color: Color(0xFF123c69),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "\u{20B9} 200/-",
                                          style: TextStyle(
                                            color: Color(0xFF123c69),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Color(0xFF123c69),
                                radius: MediaQuery.of(context).size.width / 2,
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return BillPage(
                                      user: me,
                                    );
                                  }));
                                },
                                child: Card(
                                  color: Color(0xFFD2FDFF),
                                  shadowColor: Color(0xFF123c69),
                                  elevation: 20,
                                  margin: EdgeInsets.all(10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xFFD2FDFF),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(Icons.car_rental,
                                            size: 40, color: Color(0xFF123c69)),
                                        Text(
                                          "Car",
                                          style: TextStyle(
                                            color: Color(0xFF123c69),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "\u{20B9} 350/-",
                                          style: TextStyle(
                                            color: Color(0xFF123c69),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget getMap(applicationBloc) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
            //target: LatLng(19.0735, 72.8995),zoom:5),
            target: LatLng(applicationBloc.currentLocation.latitude,
                applicationBloc.currentLocation.longitude),
            zoom: 15),
        // markers: _markers.values.toSet(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      var lat = detail.result.geometry.location.lat;
      var long = detail.result.geometry.location.lng;
      var address = detail.result.formattedAddress;
      print(lat);
      print(long);
      print(address);

      setState(() {
        _pickUp.text = address;
      });
    }
  }

  loader(BuildContext context) {
    return showDialog(
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
  }

  void showMessageSnackBar(String message) {
    final snackBar = new SnackBar(
      content: new Text("$message"),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void onLoading(BuildContext context, UserProfile me) {
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
                return BillPage(
                  user: me,
                );
              })),
            });
  }
}
