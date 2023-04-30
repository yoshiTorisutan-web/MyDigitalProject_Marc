import 'package:marc_project/screens/connexion.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/constants.dart';

//Page d'accueil de l'application

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Stack(children: [
              Positioned(
                top: -size.width / 1.5,
                left: -size.width / 2,
                child: Container(
                  width: size.width * 2,
                  height: size.width * 1.5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Constants().secondaryColor,
                  ),
                ),
              ),
              Positioned(
                  top: 100,
                  left : 125,
                  child: Center(
                    child: Container(
                      width: size.width * 0.5,
                      height: size.width * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constants().secondaryColor,
                      ),
                      child: SvgPicture.asset(
                        'assets/MAARC.svg',
                        width: size.width * 0.4,
                        height: size.width * 0.4,
                      ),
                    ),
                  )),
              Positioned.fill(
                bottom: size.height * 0.1,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 250,
                            ),
                            Text(
                              'Marc.',
                              style: TextStyle(
                                color: Constants().textColor,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontFamily: "NiceSugar",
                              ),
                            ),
                            Text(
                              'Payez & partez !',
                              style: TextStyle(
                                color: Constants().textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NiceSugar",
                              ),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FutureBuilder(
                                      future: Future.delayed(
                                        const Duration(seconds: 5),
                                        () => "Data Loaded",
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Scaffold(
                                            backgroundColor:
                                                Constants().primaryColor,
                                            body: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  LoadingAnimationWidget
                                                      .inkDrop(
                                                    color: Constants()
                                                        .secondaryColor,
                                                    size: 50,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  const Padding(
                                                    padding: EdgeInsets.all(10),
                                                  ),
                                                  Text(
                                                    'Loading ...',
                                                    style: TextStyle(
                                                      color: Constants()
                                                          .secondaryColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22.0,
                                                      fontFamily: 'Hubballi',
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        } else {
                                          return const LoginPage();
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: size.width * 0.6,
                                decoration: BoxDecoration(
                                  color: Constants().secondaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  border: Border.all(
                                    color: Constants().secondaryColor,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Prêt ?',
                                    style: TextStyle(
                                      color: Constants().thirdColor,
                                      fontSize: 22,
                                      fontFamily: 'Hubballi',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              )
            ])));
  }
}
