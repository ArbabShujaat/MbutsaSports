import 'package:flutter/material.dart';

import 'login_navigator.dart';

class OwnLogin extends StatefulWidget {
  @override
  _OwnLoginState createState() => _OwnLoginState();
}

class _OwnLoginState extends State<OwnLogin> {
  @override
  Widget build(BuildContext context) {
    return Material(child: Container(child: LoginNavigator()));
  }
}
