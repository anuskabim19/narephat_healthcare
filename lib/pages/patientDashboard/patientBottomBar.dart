import 'package:flutter/material.dart';
import 'package:health_care/pages/patientDashboard/bookAppointmentForm.dart';
import 'package:health_care/pages/patientDashboard/notification.dart';
import 'package:health_care/pages/patientDashboard/patientInfo.dart';
import '../../model/user.dart';
import 'patientDashboard.dart';
// import 'patient_home.dart';

class Patientbottonbar extends StatefulWidget {
  @override
  _PatientbottonbarState createState() => _PatientbottonbarState();
}

class _PatientbottonbarState extends State<Patientbottonbar> {
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          PatientDashboard(),
          BookAppointment(
              doctor: Doctor(
                  address: '',
                  bio: '',
                  clinicName: '',
                  counter: 0,
                  displayName: '',
                  educationalQualification: '',
                  email: '',
                  fee: '',
                  name: '',
                  paymentMethod: '',
                  photoURL: '',
                  timing: '',
                  uid: '')), // Replace with the BookAppointment widget
          ShowNotification(),
          PatientInfo(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Colors.indigo,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
