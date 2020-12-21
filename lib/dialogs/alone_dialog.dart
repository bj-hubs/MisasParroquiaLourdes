import 'package:misas/shared/global.dart';
import 'package:misas/widgets/button_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AloneDialog extends StatefulWidget {
  final int subsidiaryIndex ;
  final int inArrayPosition;

  const AloneDialog({Key key, @required this.subsidiaryIndex, this.inArrayPosition})
      : super(key: key);

  @override
  _AloneDialogState createState() => _AloneDialogState();
}

class _AloneDialogState extends State<AloneDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _content(context),
    );
  }

  _content(BuildContext context) => Container(
        height: 330,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Global.primary,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Escoja una opción',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ButtonContainer(
                    text: 'Solo Yo',
                    action: () {
                      Navigator.of(context).pushNamed('/mass/choose',
                          arguments: [widget.subsidiaryIndex.toString(), '1', widget.inArrayPosition.toString()]);
                    },
                  ),
                  ButtonContainer(
                    text: 'Con Acompañante(s)',
                    action: () {
                      Navigator.of(context).pushNamed('/mass/quantity', arguments: [widget.subsidiaryIndex.toString(),  widget.inArrayPosition.toString()]);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        color: Colors.red[300],
                        child: Icon(
                          FontAwesomeIcons.times,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
}
