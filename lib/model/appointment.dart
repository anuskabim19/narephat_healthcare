import 'dart:io';

class Appointment {
  String name,
      gender,
      comment,
      stringimage,
      clinicName,
      doctorId,
      patientId,
      patientAppointmentId,
      doctorAppointmentId;
  int age, appointmentNumber;
  bool confirmed;
  File? image;
  Appointment(
      {required this.name,
      required this.gender,
      required this.patientAppointmentId,
      required this.doctorAppointmentId,
      required this.comment,
      required this.age,
      required this.patientId,
      required this.image,
      required this.doctorId,
      required this.stringimage,
      required this.clinicName,
      required this.confirmed,
      required this.appointmentNumber});
}
