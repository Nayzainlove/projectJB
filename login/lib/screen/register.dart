import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/model/patient.dart';
import 'package:login/model/profile.dart';
import 'package:login/screen/home.dart';
import 'package:login/screen/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fromKey = GlobalKey<FormState>();
  Profile myprofile = Profile();
  Patient mypatient = Patient();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _profilecollection =
      FirebaseFirestore.instance.collection("profile");

  List<String> items = ['พนักงาน', 'ผู้จัดการ'];
  String dropdownValue = 'พนักงาน';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              // appBar: AppBar(
              //   title: Text("Sign Up"),

              // ),

              body: Container(
                  height: 800,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        Color.fromARGB(255, 151, 95, 34),
                        Color.fromARGB(255, 131, 91, 38),
                        Color.fromARGB(255, 94, 59, 20)
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Form(
                      key: fromKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "เพิ่มบัญชีพนักงาน",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 253, 253, 253),
                                    letterSpacing: 1,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 231, 231),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: 'อีเมล',
                                ),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText:
                                          "        กรุณาป้อนอีเมลด้วยครับ\n"),
                                  EmailValidator(
                                      errorText:
                                          "        รูปแบบอีเมลไม่ถูกต้อง\n")
                                ]),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (String? email) {
                                  myprofile.email = email;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 231, 231),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  hintText: 'รหัสผ่าน',
                                ),
                                validator: RequiredValidator(
                                    errorText:
                                        "        กรุณาป้อนรหัสผ่านด้วยครับ\n"),
                                obscureText: true,
                                onSaved: (String? password) {
                                  myprofile.password = password;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 231, 231),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.people_alt,
                                    color: Colors.black,
                                  ),
                                  hintText: 'ชื่อ',
                                ),
                                onSaved: (String? name) {
                                  mypatient.name = name;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 231, 231),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.people_alt,
                                    color: Colors.black,
                                  ),
                                  hintText: 'นามสกุล',
                                ),
                                onSaved: (String? lastName) {
                                  mypatient.lastname = lastName;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 231, 231),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(13, 8, 10, 8),
                                    child: Icon(
                                      Icons.people_alt,
                                      color: Colors.black,
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    iconSize: 24,
                                    elevation: 16,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownValue = newValue!;
                                      });
                                      print(newValue);
                                    },
                                    value: dropdownValue,
                                    items: items.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),

                                    // decoration: InputDecoration(
                                    //   border: InputBorder.none,
                                    //   prefixIcon: Icon(
                                    //     Icons.people_alt,
                                    //     color: Colors.black,
                                    //   ),
                                    //   hintText: dropdownValue,
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 700,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 238, 231, 231),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    Icons.phone_android,
                                    color: Colors.black,
                                  ),
                                  hintText: 'เบอร์โทร',
                                ),
                                onSaved: (String? phone) {
                                  mypatient.phone = phone;
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              child: Center(
                                child: Container(
                                  width: 500,

                                  // ignore: deprecated_member_use
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return LoginScreen();
                                            }));
                                          },
                                          child: Text(
                                            "ยกเลิก",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 253, 253, 253),
                                              letterSpacing: 1,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'OpenSans',
                                            ),
                                          )),
                                      ElevatedButton(
                                        // elevation: 5.0,
                                        onPressed: () async {
                                          if (fromKey.currentState!
                                              .validate()) {
                                            fromKey.currentState!.save();

                                            _profilecollection
                                                .doc(myprofile.email)
                                                .set({
                                              "Email": myprofile.email,
                                              "Password": myprofile.password,
                                              "Name": mypatient.name,
                                              "Lastname": mypatient.lastname,
                                              "position": dropdownValue,
                                              "Phone": mypatient.phone,
                                            });

                                            try {
                                              await FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                      email: myprofile.email!,
                                                      password:
                                                          myprofile.password!)
                                                  .then((value) {
                                                fromKey.currentState?.reset();
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "สร้างบัชชีผู้ใช้เรียบร้อยเเล้ว",
                                                    gravity: ToastGravity.TOP);
                                                Navigator.pushReplacement(
                                                    context, MaterialPageRoute(
                                                        builder: (context) {
                                                  return LoginScreen();
                                                }));
                                              });
                                            } on FirebaseAuthException catch (e) {
                                              print(e.code);
                                              String message;
                                              if (e.code ==
                                                  'email-already-in-use') {
                                                message =
                                                    "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
                                              } else if (e.code ==
                                                  'weak-password') {
                                                message =
                                                    "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                                              } else {
                                                message = e.message!;
                                              }
                                              Fluttertoast.showToast(
                                                  msg: message,
                                                  gravity: ToastGravity.CENTER);
                                            }
                                          }

                                          // myprofile.email == null ||
                                          //     myprofile.email!.isEmpty ||
                                          //     myprofile.password == null ||
                                          //     myprofile.password!.isEmpty ||
                                          //     mypatient.name == null ||
                                          //     mypatient.name!.isEmpty ||
                                          //     mypatient.lastname == null ||
                                          //     mypatient.lastname!.isEmpty ||
                                          //     mypatient.phone == null ||
                                          // mypatient.phone!.isEmpty
                                          // (fromKey.currentState!.validate())

                                          //  else if (){

                                          //  }
                                        },
                                        // padding: EdgeInsets.all(15.0),
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius: BorderRadius.circular(30.0),
                                        // ),
                                        // color: Color.fromARGB(255, 46, 43, 43),
                                        child: Text(
                                          'ยืนยัน',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            letterSpacing: 1,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                          ),
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
                  )),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
