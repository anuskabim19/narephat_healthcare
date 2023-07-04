import 'package:health_care/model/appointment.dart';
import 'package:health_care/pages/doctorDashboard/confirmAppointment.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DocNotTile extends StatelessWidget {
  Appointment appointment;
  String msg=false as String;
  DocNotTile({super.key, required this.appointment}) {
    msg = appointment.confirmed
        ? "You Confirmed ${appointment.name} Appointment"
        : "${appointment.name} wants to book appointment.";
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmAppointment(
                        appointment: appointment,
                        msg: msg,
                      )));
        },
        child: Card(
          child: ListTile(
            title: Text(msg),
          ),
        ));
  }
}
