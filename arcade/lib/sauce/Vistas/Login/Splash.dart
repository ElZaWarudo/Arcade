import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /*Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff683ab7),
                    Color(0xff683ab7),
                    Color(0xff334db2),
                    Color(0xff3955bc)
                  ]),
            ),
          ),*/
          Center(
            child: Image.asset(
              'lib/assets/varcade.png',
              height: 250.0,
            ),
          ),
        ],
      ),
    );
  }
}
