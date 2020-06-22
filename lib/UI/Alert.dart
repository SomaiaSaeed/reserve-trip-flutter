import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleActionAlert {
  final String message;
  final String buttonTitle;
  final BuildContext context;

  SingleActionAlert({
    this.message,
    this.buttonTitle,
    @required this.context,
  });

  Future<void> showAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: alertView,
    );
  }

  Widget alertView(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      content: alertContent(context),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 5),
    );
  }

  SingleChildScrollView alertContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          alertMessage(),
          SizedBox(height: 30),
          alertActions(context),
        ],
      ),
    );
  }

  Text alertMessage() {
    return Text(
      message ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 25),
    );
  }

  Widget alertActions(BuildContext context) {
    return FlatButton(
      child: Text(
        buttonTitle,
        style: TextStyle(color: Colors.blue, fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
