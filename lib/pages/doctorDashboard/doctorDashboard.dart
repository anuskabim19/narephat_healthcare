import 'package:health_care/model/user.dart';
import 'package:health_care/pages/doctorProfileForm.dart';
import 'package:health_care/pages/role.dart';
import 'package:health_care/services/auth.dart';
import 'package:health_care/services/backend.dart';
import 'package:health_care/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  late Doctor doctor;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDoctorDetails();
  }

  void getDoctorDetails() async {
    setState(() => isLoading = true);
    DocumentSnapshot doc = await doctorCollection.doc(currentUser.uid).get();
    var docData = doc.data() as Map;
    doctor = Doctor(
        address: docData["address"],
        bio: docData["bio"],
        clinicName: docData["clinicName"],
        displayName: docData["displayName"],
        educationalQualification: docData["educationalQualification"],
        email: docData["email"],
        fee: docData["fee"],
        paymentMethod: docData["paymentMethod"],
        photoURL: docData["photoURL"],
        timing: docData["timing"],
        uid: currentUser.uid,
        counter: docData["counter"], name: '');
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Container(
            child: Scaffold(
              appBar: AppBar(
                title: Text(doctor.clinicName),
                backgroundColor: Colors.indigo,
              ),
              body: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Container(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(doctor.photoURL),
                            radius: 40,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 10),
                          child: ClipOval(
                            child: Material(
                              color: Colors.transparent, // button color
                              elevation: 0.0,
                              child: InkWell(
                                splashColor: Colors.blueGrey, // inkwell color
                                child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                      Icons.edit,
                                      size: 25,
                                    )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorProfileForm(
                                                doctor: doctor,
                                                isEdit: true,
                                                user: MyUser(
                                                    uid: 'null',
                                                    displayName: '',
                                                    email: '',
                                                    photoURL: ''),
                                              )));
                                },
                              ),
                            ),
                          )),
                      Center(
                        child: Text(
                          doctor.clinicName,
                          style: TextStyle(
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Divider(),
                      SizedBox(
                        height: 30,
                      ),
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Dr. ' + doctor.displayName,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text(
                                doctor.educationalQualification,
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              doctor.bio,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Address : ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    doctor.address,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text(
                                    'Timing : ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    doctor.timing,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text(
                                    'UPI Id : ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    doctor.paymentMethod,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Text(
                                    'Fees : ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    doctor.fee + ' rs. at clinic',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: ElevatedButton(
                          child: Text(
                            "Log Out",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () {
                            // Navigator.pop(context);
                            AuthServices().signOutGoogle();
                          },
                          //color: Colors.indigo,
                        ),
                      ),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
