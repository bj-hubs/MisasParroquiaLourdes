import 'package:misas/dialogs/dialog_helper.dart';
import 'package:misas/shared/global.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MassScreen extends StatefulWidget {
  @override
  _MassScreenState createState() => _MassScreenState();
}

class _MassScreenState extends State<MassScreen> {
  List<Image> imgs = <Image>[];
  int _current = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(color: Colors.white.withAlpha(0), child: SizedBox(),),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Misas'),
        backgroundColor: Global.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:40.0),
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      height: size.height * 0.8,
                      initialPage: 0,
                      onPageChanged: (index, changed) {
                        setState(
                          () {
                            _current = index;
                          },
                        );
                      }),
                  items: Global.subsidiaries.map(
                    (sub) {
                      return Builder(
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 15, right: 15, top: 30, bottom: 30),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 7,
                                      blurRadius: 10,
                                      offset: Offset(0, 1)),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 300,
                                    padding: EdgeInsets.all(5.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                      color: Global.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        sub.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DialogHelper.subsidiary = int.parse(sub.id);
                                      DialogHelper.position = _current;
                                      DialogHelper.alone(context);
                                    },
                                    child: Container(
                                      width: 300,
                                      height: size.height * 0.4,
                                      color: Colors.transparent,
                                      child: ClipRRect(
                                        child: Image.network(sub.image, fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    padding: EdgeInsets.all(5.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      color: Global.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        sub.community,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('/mass/delete');
        },
        child: Icon(FontAwesomeIcons.solidTrashAlt),
        backgroundColor: Global.primary,
      ),
    );
  }
}
