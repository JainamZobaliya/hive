import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserProfile {
  String userId;
  String customerId;
  String fullName;
  String emailId;
  String mobileNo;
  String gender;
  int age;
  bool status;
  FirebaseAuth auth;

  void setLogInStatus(bool status) {
    this.status = status;
  }

  DatabaseReference mDatabase = FirebaseDatabase.instance.reference();

  UserProfile({String userId}) {
    this.userId = userId;
    getFormData(userId);
  }

  void setCustomerId(String data)
  {
    this.customerId = data;
  }

  void setEmailId(String data) {
    this.emailId = data;
  }

  void setFullName(String data) {
    this.fullName = data;
  }

  void setMobileNo(String data) {
    this.mobileNo = data;
  }

  void setAge(int data) {
    this.age = data;
  }

  void setGender(String data) {
    this.gender = data;
  }

  Future<void> getFormData(String userId) async {
    final uid = userId;
    final dbRef = FirebaseDatabase.instance.reference();
    await dbRef.once().then((DataSnapshot snapshot) async {
      snapshot.value.forEach((key, val) => val.forEach((key, val){
        if (key == uid) {
          setCustomerId(val['customerId']);
          setEmailId(val['emailId']);
          setFullName(val['fullName']);
          setMobileNo(val['mobileNo']);
          setAge(val['age']);
          setGender(val['gender']);
          print('Email Id.: ${this.emailId}');
          print('Full Name: ${this.fullName}');
          print('Mobile No.: ${this.mobileNo}');
          print('Age: ${this.age}');
          print('Gender: ${this.gender}');
        }
        })
    );});
    }

  // FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<LogInPage> signOut() async {
  //   await _auth.signOut();
  //   return LogInPage();
  // }
}
