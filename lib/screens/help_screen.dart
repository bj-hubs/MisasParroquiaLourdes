import 'package:misas/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Global.primary,
        centerTitle: true,
        title: Text('Contácto'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  onPressed: (){
                    _launchURL('https://www.facebook.com/parroquiadelourdes');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FontAwesomeIcons.facebookSquare,
                        size: 40, color: Colors.white),
                        Text(
                          ' Página de Facebook',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.blue[500],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  onPressed: (){
                    _launchURL('https://www.youtube.com/channel/UCEEmYYyC2uIhSEi9Ul87Cdw');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FontAwesomeIcons.youtube,
                        size: 40,
                        color: Colors.white),
                        Text(
                          'Canal de YouTube',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.red[500],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  onPressed: (){
                    _launchURL('https://iglesiadelourdes.com');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FontAwesomeIcons.internetExplorer,
                        size: 40,
                        color: Colors.white),
                        Text(
                          'Página web',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  color: Global.secondary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo cargar la dirección';
    }
  }
}