import 'package:health_care/model/appointment.dart';
import 'package:health_care/pages/patientDashboard/AppointmentFormStatus.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PatNotTile extends StatelessWidget {
  Appointment appointment;
  String msg = "";
  Icon? icon;
  PatNotTile({super.key, required this.appointment}) {
    msg = appointment.confirmed
        ? "Your Appointment in ${appointment.clinicName} is confirmed "
        : "Your Appointment in ${appointment.clinicName} is pending";
    icon = appointment.confirmed
        ? Icon(
            Icons.check_box,
            color: Colors.green,
            size: 30,
          )
        : Icon(
            Icons.pending_actions,
            color: Colors.red,
            size: 30,
          );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppointmentFormStatus(
                      appointment: appointment,
                    )));
      },
      child: Card(
          // child: ListTile(
          //   title: Text(
          //     msg,
          //   ),
          // ),
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Text(
              msg,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            //icon,
          ],
        ),
      )),
    );
  }
}
