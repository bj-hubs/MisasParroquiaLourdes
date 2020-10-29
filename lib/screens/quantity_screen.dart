import 'package:Misas/shared/global.dart';
import 'package:Misas/widgets/button_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuantityScreen extends StatefulWidget {
  final int subsidiaryIndex;

  const QuantityScreen({Key key, this.subsidiaryIndex}) : super(key: key);

  @override
  _QuantityScreenState createState() => _QuantityScreenState();
}

class _QuantityScreenState extends State<QuantityScreen> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Acompañantes'),
        backgroundColor: Global.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(
                FontAwesomeIcons.users,
                size: 80.0,
                color: Global.primary.withOpacity(0.4),
              ),
            ),
            Text(
              '¿Cuántos Acompañantes?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15.0, bottom: 20),
              child: Text(
                'Seleccione la cantidad y presione siguiente',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0, bottom: 10.0),
              child: Container(
                width: double.infinity,
                child: DropdownButton(
                    isExpanded: true,
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("1 Acompañante"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("2 Acompañantes"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("3 Acompañantes"),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text("4 Acompañantes"),
                        value: 4,
                      ),
                      DropdownMenuItem(
                        child: Text("5 Acompañantes"),
                        value: 5,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    }),
              ),
            ),
            ButtonContainer(
              text: 'Continuar',
              action: () {
                Navigator.of(context).pushNamed('/mass/choose', arguments: [
                  widget.subsidiaryIndex.toString(),
                  (_value + 1).toString()
                ]);
              },
              width: double.infinity,
              color: Global.primary,
              txtColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
