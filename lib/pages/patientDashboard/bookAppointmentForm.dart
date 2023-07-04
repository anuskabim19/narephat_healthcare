import 'dart:io';
import 'package:health_care/model/appointment.dart';
import 'package:health_care/model/user.dart';
import 'package:health_care/pages/patientDashboard/notification.dart';
import 'package:health_care/pages/role.dart';
import 'package:health_care/services/backend.dart';
import 'package:health_care/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class BookAppointment extends StatefulWidget {
  Doctor doctor;
  BookAppointment({required this.doctor});

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController commentController = new TextEditingController();
  bool validName = true, validAge = true, validGender = true, isLoading = false;

  File? image;
  final picker = ImagePicker();
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        setState(() => image = File(pickedFile.path));
      }
    });
  }

  void bookAppointment() async {
    String name = nameController.text.trim();
    String age = ageController.text.trim();
    String gender = genderController.text.trim();
    String comment = commentController.text.trim();
    setState(() {
      validName = name.isNotEmpty;
      validAge = age.isNotEmpty;
      validGender = gender.isNotEmpty;
    });
    if (validName && validAge && validGender) {
      setState(() => isLoading = true);
      Appointment appoit = Appointment(
        name: name,
        age: int.parse(age),
        gender: gender,
        comment: comment,
        clinicName: widget.doctor.clinicName,
        image: image,
        confirmed: false,
        appointmentNumber: 0,
        doctorAppointmentId: '',
        doctorId: '',
        patientAppointmentId: '',
        patientId: '',
        stringimage: '',
      );

      await Backend()
          .bookAppointment(appoit, widget.doctor.uid, currentUser.uid);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ShowNotification()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Appointment")),
      body: isLoading
          ? Loading()
          : Padding(
              padding: const EdgeInsets.all(13.0),
              child: ListView(children: [
                Center(
                    child: Text(
                  widget.doctor.clinicName,
                  style: TextStyle(fontSize: 30),
                )),
                SizedBox(height: 40),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: "Enter Patient Name",
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      errorText: validName ? null : "Name Can't Be Empty"),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: "Enter Patient Age",
                      border: OutlineInputBorder(),
                      labelText: "Age",
                      errorText: validAge ? null : "Age Can't Be Empty"),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: genderController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: "Enter Patient Gender",
                      border: OutlineInputBorder(),
                      labelText: "Gender",
                      errorText: validGender ? null : "Gender Can't Be Empty"),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: commentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[50],
                    hintText: "Add Edition Comment",
                    border: OutlineInputBorder(),
                    labelText: "Comment(optional)",
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  child: Text("Upload ScreenShot of payment "),
                  onPressed: () {
                    getImageFromGallery();
                  },
                ),
                // ignore: unnecessary_null_comparison
                (image == null)
                    ? Text("no file selected(required)")
                    : Hero(
                        tag: "heroImage",
                        child: AspectRatio(
                          aspectRatio: 0.85,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(image!),
                                    fit: BoxFit.cover)),
                          ),
                        )),
                ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    bookAppointment();
                  },
                )
              ]),
            ),
    );
  }
}
