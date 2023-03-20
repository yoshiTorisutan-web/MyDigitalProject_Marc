import 'package:Marc_project/screens/connexion.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/sac-a-main.png',
                width: 250,
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Marc',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Hubballi',
                    ),
                  ),
                  const Text(
                    'payez & partez !',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Hubballi',
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FutureBuilder(
                                    future: Future.delayed(
                                        const Duration(seconds: 5),
                                        () => "Data Loaded"),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Scaffold(
                                          backgroundColor:
                                              const Color.fromARGB(255, 255, 255, 255),
                                          body: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                LoadingAnimationWidget.inkDrop(
                                                  color:
                                                      const Color.fromARGB(255, 0, 0, 0),
                                                  size: 50,
                                                ),
                                                const SizedBox(height: 20),
                                                const Padding(
                                                    padding:
                                                        EdgeInsets.all(10)),
                                                const Text(
                                                  'Loading ...',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(255, 0, 0, 0),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 22.0,
                                                      fontFamily: 'Hubballi'),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const LoginPage();
                                      }
                                    },
                                  )));
                    },
                    child: Container(
                      height: 50,
                      width: size.width * 0.6,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff232526), Color(0xff414345)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.2, 0.85]),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Center(
                        child: Text(
                          'Get started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
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
    ));
  }
}
