import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class DesktopScreen extends StatefulWidget {
  const DesktopScreen({Key? key}) : super(key: key);

  @override
  State<DesktopScreen> createState() => _DesktopScreenState();
}

class _DesktopScreenState extends State<DesktopScreen> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    bool isPasswordVissible = false;
    final TextEditingController psswd = TextEditingController();
    final TextEditingController user = TextEditingController();
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ListView(
              children: [
                Container(
                  color: const Color.fromARGB(255, 9, 40, 125),
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.scale(
                        scale: 2,
                        child: SizedBox(
                          width: 300,
                          height: 80,
                          child: Image.network(
                            'https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/c6juod4ctpabydcrj79k',
                            fit: BoxFit.scaleDown,
                            scale: 1,
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text('Customer Service',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              width: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 80),
                              child: Text('Locations',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ])
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 400),
                  color: Colors.white,
                  child: Column(children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Account Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color.fromARGB(255, 9, 40, 125),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Account type',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                      child: TextFormField(
                          controller: user,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.name,
                          onSaved: (value) => user.text = value!,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            hoverColor: Colors.white,
                            filled: true,
                            fillColor: CupertinoColors.white,
                            //focusedBorder: OutlineInputBorder(),
                            focusColor: CupertinoColors.black,
                            border: UnderlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            contentPadding: EdgeInsets.only(
                                top: 0, bottom: 0, left: 2, right: 2),
                          ),
                          validator: (ifuser) {
                            if (ifuser!.isEmpty && ifuser.length < 4) {
                              return 'Please enter a valid User ID';
                            } else {
                              return null;
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            focusColor: Colors.white,
                            value: isChecked,
                            onChanged: (value) => setState(() {
                              isChecked = value!;
                            }),
                            activeColor: CupertinoColors.activeBlue,
                            checkColor: CupertinoColors.white,
                            hoverColor: CupertinoColors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            side: const BorderSide(width: 0.5),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Remember My Username'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hoverColor: Colors.white,
                        filled: true,
                        fillColor: CupertinoColors.white,
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(),
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 0, bottom: 0, left: 2, right: 2),
                      ),
                      obscureText: isPasswordVissible,
                      controller: psswd,
                      validator: (ifpsswd) {
                        if (ifpsswd!.isNotEmpty && ifpsswd.length < 6) {
                          return 'Please enter a correct password';
                        } else {
                          return null;
                        }
                      },
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          debugPrint(
                              'User ID:${user.text} Password:${psswd.text}');

                          FutureBuilder(
                              future: Database(
                                      pass: psswd.text, username: user.text)
                                  .getinfo(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return const DesktopScreen();
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              });

                          // final User? user = await _auth.emailPasswordSignIn(
                          //       email: user.text, password: psswd.text);

                          // setState(() {
                          //   isProgress = false;
                          // });

                          // if (user != null) {
                          //   Navigator.of(context).pushAndRemoveUntil(
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               Homepage(user: user)),
                          //       (route) => false);
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: CupertinoColors.systemRed,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          minimumSize: const Size.fromHeight(50),
                          fixedSize: const Size(150, 30),
                        ),
                        child: const Text('Log in',
                            style: TextStyle(
                                fontSize: 20, color: CupertinoColors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Get login help',
                          style: TextStyle(
                            fontSize: 15,
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Create a username and password',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                BottomAppBar(
                    elevation: 0,
                    color: const Color.fromARGB(255, 249, 247, 247),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // const Icon(Icons.lock,
                              //     color: CupertinoColors.activeBlue),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Connection secured',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: CupertinoColors.activeBlue,
                                  ),
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Security |',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CupertinoColors.activeBlue,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Privacy |',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CupertinoColors.activeBlue,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'CoBrowse',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: CupertinoColors.activeBlue,
                                        ),
                                      ),
                                    )
                                  ])
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('©2022 U.S Bank',
                                style: TextStyle(fontSize: 13)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('OLB Cloud: 1.58.0_BN_2061',
                                style: TextStyle(fontSize: 13)),
                          ),
                          const Divider(
                            thickness: 0.2,
                            color: Colors.black,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                                'Investment and Insurance products and services including annuities are:',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                                'Not a Deposit. Not FDIC . May Loose Value . Not Bank Guaranteed . Not Insured by any Federal Government Agency',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
