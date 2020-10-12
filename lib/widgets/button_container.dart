import 'package:Misas/shared/global.dart';
import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final Function action;

  const ButtonContainer(
      {Key key, this.text, this.color = Global.secondary, this.width = 300, this.action})
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
            padding: const EdgeInsets.all(15.0),
            child: Text(
              text,
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),
          ),
          color: color,
        ),
      ),
    );
  }
}
