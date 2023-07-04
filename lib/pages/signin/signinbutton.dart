import 'package:health_care/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignButton extends StatelessWidget {
  final String name;
  Function toggleLoading;
  SignButton({required this.name, required this.toggleLoading});

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();

    return RawMaterialButton(
      shape: StadiumBorder(),
      onPressed: () {
        toggleLoading();
        _auth.signInWithGoogle();
      },
      fillColor: Colors.white,
      splashColor: Colors.grey,
      hoverElevation: 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Text(
              '$name',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
