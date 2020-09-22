import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qvid/Components/continue_button.dart';
import 'package:qvid/Components/entry_field.dart';
import 'package:qvid/Locale/locale.dart';

//Verification page that sends otp to the phone number entered on phone number page
class VerificationPage extends StatelessWidget {
  final VoidCallback onVerificationDone;

  VerificationPage(this.onVerificationDone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).verification),
      ),
      body: VerificationBody(onVerificationDone),
    );
  }
}

//otp verification class
class VerificationBody extends StatefulWidget {
  final VoidCallback onVerificationDone;

  VerificationBody(this.onVerificationDone);

  @override
  _VerificationBodyState createState() => _VerificationBodyState();
}

class _VerificationBodyState extends State<VerificationBody> {
  bool isDialogShowing = false;
  int _counter = 20;
  Timer _timer;

  _startTimer() {
    //shows timer
    _counter = 20; //time counter

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber();
  }

  void verifyPhoneNumber() {
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 20.0, bottom: 16.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '\n' + locale.enterCode + '+91__________',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: 32.0),
          EntryField(
            label: locale.verificationCode,
            initialValue: '_ _ _ _ _ _',
            maxLength: 6,
            keyboardType: TextInputType.number,
          ),
          Spacer(),
          CustomButton(
            text: locale.submit,
            onPressed: () {
              widget.onVerificationDone();
            },
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                locale.resend,
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '$_counter ${locale.sec}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
