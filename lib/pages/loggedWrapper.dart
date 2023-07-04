import 'package:health_care/model/user.dart';
import 'package:health_care/pages/doctorDashboard/doctorBottomBar.dart';
import 'package:health_care/pages/patientDashboard/patientBottomBar.dart';
import 'package:health_care/pages/role.dart';
import 'package:health_care/services/backend.dart';
import 'package:health_care/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoggedWrapper extends StatefulWidget {

  MyUser user;
  LoggedWrapper({super.key, required this.user});
  @override
  _LoggedWrapperState createState() => _LoggedWrapperState();
}

class _LoggedWrapperState extends State<LoggedWrapper> {
  bool isLoading = true;
  late bool isDoctor,isPatient;

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  void getInfo()async{
    DocumentSnapshot docColl = await doctorCollection.doc(widget.user.uid).get();
    bool temdoc = false,temPat = false;
    temdoc  = docColl.exists;
    if(!temdoc){
      DocumentSnapshot patColl = await patientCollection.doc(widget.user.uid).get();
      temPat = patColl.exists;
      if(temPat){
        currentUser = widget.user;
        currentUser.isDoctor = false;
      }
    }else{
      currentUser = widget.user;
      currentUser.isDoctor = true;
    }
    setState((){
      isDoctor = temdoc;
      isPatient = temPat;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?Loading():(isDoctor?DoctorBottom():(isPatient?Patientbottonbar():Role(user:widget.user)));
  }
}