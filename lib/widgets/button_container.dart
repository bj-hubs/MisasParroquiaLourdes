import 'package:misas/shared/global.dart';
import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String text;
  final Color color;
  final Color txtColor;
  final double width;
  final Function action;

  const ButtonContainer(
      {Key key, this.text, this.color = Global.secondary, this.width = 300, this.action, this.txtColor = Colors.black54})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: RaisedButton(
          onPressed: action,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
            child: Text(
              text,
              style: TextStyle(color: txtColor, fontSize: 18),
            ),
          ),
          color: color,
        ),
      ),
    );
  }
}
