import 'package:Misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:string_validator/string_validator.dart';

class QuantityScreen extends StatefulWidget {
  final int subsidiaryIndex;

  const QuantityScreen({Key key, this.subsidiaryIndex}) : super(key: key);

  @override
  _QuantityScreenState createState() => _QuantityScreenState();
}

class _QuantityScreenState extends State<QuantityScreen> {
  String text = '';
  bool _nextEnabled = false, _deleteEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Acompañantes'),
        backgroundColor: Global.primary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              FontAwesomeIcons.users,
              size: 50.0,
              color: Global.primary.withOpacity(0.4),
            ),
          ),
          Text(
            '¿Cuántos Acompañantes?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Mínimo 1 - Máximo 5',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Global.secondary.withOpacity(0.5)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          NumericKeyboard(
              onKeyboardTap: _onKeyboardTap,
              textColor: Global.primary,
              rightButtonFn: _deleteEnabled ? () {
                setState(() {
                  text = text.substring(0, text.length - 1);
                  if (isNumeric(text)) {
                    _deleteEnabled = true;
                    if (int.parse(text) > 0 && int.parse(text) < 6) {
                      _nextEnabled = true;
                    } else {
                      _nextEnabled = false;
                    }
                  } else {
                    _deleteEnabled = false;
                    _nextEnabled = false;
                  }
                });
              } : null,
              rightIcon: Icon(
                Icons.backspace,
                color: _deleteEnabled ? Global.primary : Colors.grey,
              ),
              leftButtonFn: _nextEnabled ? () {
                Navigator.of(context).pushNamed('/mass/choose', arguments: [widget.subsidiaryIndex.toString(), (int.parse(text)+1).toString()]);
              } : null,
              leftIcon: Icon(
                Icons.check,
                color: _nextEnabled ? Global.primary : Colors.grey,
              ),
              mainAxisAlignment: MainAxisAlignment.spaceBetween)
        ],
      ),
    );
  }

  _onKeyboardTap(String value) {
    setState(
      () {
        if (isNumeric(value)) {
          _deleteEnabled = true;
          text = text + value;
          if (int.parse(text) > 0 && int.parse(text) < 6) {
            _nextEnabled = true;
          } else {
            _nextEnabled = false;
          }
        } else {
          _deleteEnabled = false;
          _nextEnabled = false;
        }
      },
    );
  }
}
