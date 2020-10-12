import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:flutter/material.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({
    Key key,
    this.color,
    this.start,
    this.end,
  }) : super(key: key);

  final Color color;
  final String start;
  final String end;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DialogHelper.confirmation(context);
      },
      child: Card(
        color: color,
        child: Container(
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inicia: $start',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Finaliza: $end',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Container(
                color: Colors.white.withOpacity(0.6),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Espacios',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '2/125',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
