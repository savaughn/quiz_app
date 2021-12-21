import 'package:flutter/material.dart';

import '../helpers/helper.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            stripHtml(questionText),
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w100,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            // color: Colors.blue[400],
            color: Colors.grey,
            width: 3,
          ),
          borderRadius: new BorderRadius.circular(15),
        ),
      ),
    );
  }
}
