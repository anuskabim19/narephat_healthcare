import 'package:health_care/pages/signin/signinbutton.dart';
import 'package:health_care/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLoading = false;
  void toggleLoading() {
    setState(() => isLoading = !isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Container(
                color: Colors.indigo,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .5,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(40),
                                bottomRight: const Radius.circular(40),
                              )),
                        ),
                        Center(
                          child: Container(
                            child: Image.asset(
                              'assets/doctor.png',
                              height: 300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: Text(
                        "Welcome to Narephat Health Care!",
                        style:
                            TextStyle(color: Colors.amber[300], fontSize: 40),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SignButton(
                        name: "Sign in With Google ",
                        toggleLoading: toggleLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
