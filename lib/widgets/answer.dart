import 'package:flutter/material.dart';

import '../helpers/helper.dart';

class Answer extends StatelessWidget {
  final Function onSelect;
  final String label;
  final bool isCorrect;

  Answer(this.onSelect, this.label, this.isCorrect);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: label != ''
            ? RaisedButton(
                elevation: 3,
                // padding: const EdgeInsets.all(5),
                child: Text(
                  stripHtml(label),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[50],
                  ),
                ),
                onPressed: () => onSelect(label, isCorrect),
                color: label != '' ? Colors.blue[400] : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15),
                ),
              )
            : null,
        margin: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
      ),
    );
  }
}
