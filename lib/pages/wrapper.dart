import 'package:health_care/model/user.dart';
import 'package:health_care/pages/loggedWrapper.dart';
import 'package:health_care/pages/signin/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return SignInPage();
    } else {
      return LoggedWrapper(user: user);
    }
  }
}
