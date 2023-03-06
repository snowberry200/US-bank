import 'package:flutter/material.dart';


import '../widget/textformfileds.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        backgroundColor: const Color.fromARGB(255, 41, 95, 150),
        appBar:  AppBar(
          backgroundColor: const Color.fromARGB(255, 9, 40, 125),
          title: Transform.scale(
            scale: 2,
            child: SizedBox(
              width: 300,
              height: 80,
              child: Image.network(
                  'https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/c6juod4ctpabydcrj79k',
                  fit: BoxFit.scaleDown),
            ),
          ),
          elevation: 0,
        ),
        body: const Textfields());
  }
}
