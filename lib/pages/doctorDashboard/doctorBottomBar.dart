import 'package:health_care/pages/doctorDashboard/doctorCounter.dart';
import 'package:health_care/pages/doctorDashboard/doctorDashboard.dart';
import 'package:health_care/pages/doctorDashboard/showbooking.dart';
import 'package:flutter/material.dart';

class DoctorBottom extends StatefulWidget {
  @override
  _DoctorBottomState createState() => _DoctorBottomState();
}

class _DoctorBottomState extends State<DoctorBottom> {
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
    // ignore: unnecessary_set_literal
    setState(() => {
          this.pageIndex = pageIndex,
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
        children: <Widget>[DoctorDashboard(), ShowBooking(), DoctorCounter()],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Colors.indigo,
        onTap: onTap,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: "Counter"),
        ],
      ),
    );
  }
}
