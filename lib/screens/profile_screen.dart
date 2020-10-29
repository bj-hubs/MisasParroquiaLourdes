import 'package:Misas/dialogs/dialog_helper.dart';
import 'package:Misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String fullname =
        '${Global.userInfo.name} ${Global.userInfo.lastname} ${Global.userInfo.secondLastname}';
    String id = '${Global.userInfo.id}';
    String phone = '${Global.userInfo.phone}';

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white.withAlpha(0),
        child: SizedBox(),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: Text('Cuenta'),
          backgroundColor: Global.primary,
          actions: [
            GestureDetector(
              onTap: () {
                DialogHelper.logout(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(FontAwesomeIcons.signOutAlt),
              ),
            ),
          ]),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Global.primary,
                          ),
                          child: Center(
                            child: Text(
                              'Mi Información',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Global.secondary.withOpacity(0.4),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$fullname',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Identificación: $id',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Teléfono: $phone',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 200,
                    ),
                    alignment: Alignment.bottomRight,
                    child: RawMaterialButton(
                      onPressed: () {
                        DialogHelper.editProfile(context);
                      },
                      elevation: 2.0,
                      fillColor: Global.primary,
                      child: Icon(
                        FontAwesomeIcons.edit,
                        size: 22.0,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Global.primary,
                      ),
                      child: Center(
                        child: Text(
                          'Autoevaluación de COVID-19',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Global.secondary.withOpacity(0.4),
                      ),
                      child: Container(
                        child: Center(
                          child: RaisedButton(
                            color: Global.primary,
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/profile/autocheck');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Icon(
                                FontAwesomeIcons.notesMedical,
                                size: 80,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
