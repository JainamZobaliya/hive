import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/LogInPage.dart';
import 'package:hive/UserProfile.dart';

enum Gender { male, female, others }

class RegistrationPage extends StatefulWidget {
  static const routeName = '/registrationPage';
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String fullName, emailId, password, mobileNo;
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _mobileNo = TextEditingController();

  var uid;
  bool enabled = false;
  bool checked = false;
  bool _passwordVisible = false;
  int age = 28;
  double minAge = 12;
  double maxAge = 100;
  Gender gender = Gender.others;
  String gender1 = "Others";
  bool _isSuccess;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/loginbg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Sign Up',
            style: TextStyle(
                color: Color(0xFF123c69), fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFFD2FDFF),
        ),
        body: SingleChildScrollView(
          child: registerForm(),
        ),
      ),
    );
  }

  Widget registerForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(50.0),
                border: Border.all(color: Color(0xFF123c69), width: 15.0),
                color: Color(0xFFD2FDFF),
              ),
              child: new Image.asset('images/logo.png',
                  fit: BoxFit.fitWidth, height: 150),
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                style: TextStyle(
                  color: Color(0xFF123c69),
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123c69),
                  ),
                  focusColor: Color(0xFF64DFDF),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xFF123c69),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF123c69),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  border: OutlineInputBorder(),
                ),
                controller: _fullName,
                validator: (String value) {
                  String pattern = r'(^[a-z A-Z,.\-]+$)';
                  RegExp regExp = new RegExp(pattern);
                  if (value.length == 0) {
                    return "Name cannot be Empty";
                  } else if (!regExp.hasMatch(value)) {
                    return "Name must have Alphabetic characters";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontFamily: 'Times New Roman',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                    labelText: 'Email Id.',
                    hintText: "e.g abc@gmail.com",
                    labelStyle: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF123c69),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF123c69),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF123c69),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  controller: _emailId,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) {
                    EmailValidator.validate(value)
                        ? null
                        : "Invalid Email Address";
                    return null;
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                style: TextStyle(
                  color: Color(0xFF123c69),
                  fontFamily: 'Times New Roman',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF123c69)),
                  prefixIcon:
                      Icon(Icons.lock_outline, color: Color(0xFF123c69)),
                  suffixIcon: IconButton(
                    tooltip:
                        _passwordVisible ? "Hide Password" : " Show Password",
                    color: Color(0xFF64DFDF),
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Color(0xFF123c69),
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF123c69)),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  border: OutlineInputBorder(),
                ),
                controller: _password,
                obscureText: !_passwordVisible,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  Pattern pattern =
                      r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(value)) {
                    return "Invalid Passsword";
                  } else
                    return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: TextFormField(
                  style: TextStyle(
                    color: Color(0xFF123c69),
                    fontFamily: 'Times New Roman',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                    labelText: 'Mobile No.',
                    labelStyle: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF123c69)),
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF123c69)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF123c69)),
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _mobileNo,
                  validator: (String value) {
                    String pattern = r'(^[0-9]*$)';
                    RegExp regExp = new RegExp(pattern);
                    if (value.length == 0) {
                      return "Mobile No. cannot be Empty";
                    } else if (value.length != 10) {
                      return "Must have 10 digits";
                    } else if (!regExp.hasMatch(value)) {
                      return "Mobile Number must only have digits";
                    }
                    return null;
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                margin: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFF64DFDF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Gender',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      gender1.toString(),
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 4,
                            child: new ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                ListTile(
                                  title: Text(
                                    'Male',
                                    style: TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: Radio(
                                    value: Gender.male,
                                    groupValue: gender,
                                    onChanged: (Gender value) {
                                      setState(() {
                                        gender = value;
                                        assignGender(value.toString());
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    'Female',
                                    style: TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: Radio(
                                    value: Gender.female,
                                    groupValue: gender,
                                    onChanged: (Gender value) {
                                      setState(() {
                                        gender = value;
                                        assignGender(value.toString());
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    'Others',
                                    style: TextStyle(
                                      fontFamily: 'Times New Roman',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  leading: Radio(
                                    value: Gender.others,
                                    groupValue: gender,
                                    onChanged: (Gender value) {
                                      setState(() {
                                        gender = value;
                                        assignGender(value.toString());
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(0xFF64DFDF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Age',
                      style: TextStyle(
                        fontFamily: 'Times New Roman',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          age.toString() + " years",
                          style: TextStyle(
                            fontFamily: 'Times New Roman',
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0xFF123c69),
                        inactiveTrackColor: Color(0xFFD2FDFF),
                        thumbColor: Color(0xFF123c69),
                        overlayColor: Colors.teal,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 25.0),
                      ),
                      child: Slider(
                        value: age.toDouble(),
                        min: minAge,
                        max: maxAge,
                        onChanged: (double newValue) {
                          setState(() {
                            age = newValue.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              elevation: 15.0,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(100.0)),
              textColor: Color(0xFF123c69),
              color: Color(0xFFD2FDFF),
              splashColor: Color(0xFF64DFDF),
              child: Text(
                "Register",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _registerAccount();
                } else {
                  showMessageSnackBar("Please fill the valid Details!!");
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              elevation: 0.0,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(100.0)),
              textColor: Color(0xFF123c69),
              color: Colors.transparent,
              splashColor: Color(0xFF64DFDF),
              child: Text(
                "Already a user?",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                Center(
                  child: CircularProgressIndicator(),
                );
                await Navigator.popAndPushNamed(context, LogInPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  void assignGender(String value) {
    if (value == "Gender.male") {
      gender1 = "Male";
    } else if (value == "Gender.female") {
      gender1 = "Female";
    } else {
      gender1 = "Others";
    }
  }

  void _registerAccount() async {
    final User user = (await _auth
        .createUserWithEmailAndPassword(
      email: _emailId.text,
      password: _password.text,
    )
        .then((result) async {
      uid = this.uid;
      dbRef.child(result.user.uid).set({
        "emailId": _emailId.text,
        "fullName": _fullName.text,
        "gender": gender1,
        "age": age,
        "mobileNo": _mobileNo.text,
      });
      if (result.user != null) {
        if (!result.user.emailVerified) {
          await result.user.sendEmailVerification();
        }
        showMessageSnackBar("Registration Successfull!!");
        _isSuccess = true;
        await onLoading(context, result.user.uid);
      } else {
        _isSuccess = false;
      }
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }));

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => LogInPage(uid: uid)),
    // );
  }

  void showMessageSnackBar(String message) {
    final snackBar = new SnackBar(
      content: new Text("$message"),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> onLoading(BuildContext context, var uid) {
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
                  "Please Verify Your \n Email To Continue!!",
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
    return new Future.delayed(
        new Duration(seconds: 3),
        () => {
              Navigator.pop(context), //pop dialog
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return LogInPage(uid: uid);
              })),
            });
  }
}
