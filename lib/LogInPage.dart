import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/BillPage.dart';
import 'package:hive/HomePage.dart';
import 'package:hive/RegistrationPage.dart';
import 'package:hive/UserProfile.dart';

class LogInPage extends StatefulWidget {
  static const routeName = '/logInPage';
  String uid;
  LogInPage({uid});
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailId = TextEditingController();
  bool _passwordVisible = false;
  final TextEditingController _password = TextEditingController();

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
            'Log In',
            style: TextStyle(
                color: Color(0xFF123c69), fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color(0xFFD2FDFF),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _key,
              child: logInForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget logInForm() {
    return SingleChildScrollView(
      child: Column(
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
                  fontFamily: 'Times New Roman',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                controller: _emailId,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                  labelText: 'Email Id.',
                  labelStyle: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF123c69),
                  ),
                  focusColor: Color(0xFF123c69),
                  prefixIcon: Icon(Icons.person, color: Color(0xFF123c69)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF123c69)),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  border: OutlineInputBorder(),
                ),
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
                  color: Color(0xFF123c69),
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Color(0xFF123c69),
                ),
                suffixIcon: IconButton(
                  tooltip:
                      _passwordVisible ? "Hide Password" : " Show Password",
                  color: Color(0xFF123c69),
                  icon: Icon(
                    _passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFF123c69),
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF123c69),
                  ),
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
          MaterialButton(
            elevation: 15.0,
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100.0)),
            textColor: Color(0xFF123c69),
            color: Color(0xFFD2FDFF),
            splashColor: Color(0xFF64DFDF),
            child: Text(
              "Log In",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            onPressed: () async {
              Center(
                child: CircularProgressIndicator(),
              );
              if (_key.currentState.validate()) {
                _signInWithEmailAndPassword();
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
            textColor: Color(0xFF64DFDF),
            color: Colors.transparent,
            splashColor: Color(0xFF123c69),
            child: Text(
              "New User?",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              Center(
                child: CircularProgressIndicator(),
              );
              await Navigator.pushNamed(context, RegistrationPage.routeName);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailId.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailId.text,
        password: _password.text,
      ))
          .user;
      final user1 = _auth.currentUser;
      var userId = user1.uid;
      UserProfile me = new UserProfile(userId: userId);
      if (!user.emailVerified) {
        showMessageSnackBar("Please Verify your Email.");
        await user.sendEmailVerification();
      } else {
        onLoading(context, me);
      }
    } catch (err) {
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
    }
  }

  void showMessageSnackBar(String message) {
    final snackBar = new SnackBar(
      content: new Text("$message"),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // ignore: unused_element
  // void _signOut() async {
  //   await _auth.signOut();
  // }

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
                return HomePage(
                  user: me,
                );
              })),
            });
  }
}
