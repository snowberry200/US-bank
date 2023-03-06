// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usbank/services/database.dart';
// import 'package:usbank/services/database.dart';

class Textfields extends StatefulWidget {
  const Textfields({
    Key? key,
  }) : super(key: key);

  @override
  State<Textfields> createState() => _TextfieldsState();
}

class _TextfieldsState extends State<Textfields> {
  //User? user;
  bool isProgress = false;
  //final _auth = Authservice();
  //late String collect;
  bool isPasswordVissible = false;
  final TextEditingController psswd = TextEditingController();
  final TextEditingController user = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Hello',
            style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 28),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
          child: Align(
              alignment: Alignment.topLeft,
              child: Text('Personal ID',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18))),
        ),
        Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children: [
                TextFormField(
                    controller: user,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    onSaved: (value) => user.text = value!,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: CupertinoColors.white,
                        focusedBorder: OutlineInputBorder(),
                        focusColor: CupertinoColors.black,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        contentPadding: EdgeInsets.all(10)),
                    validator: (ifuser) {
                      if (ifuser!.isEmpty && ifuser.length < 4) {
                        return 'Please enter a valid User ID';
                      } else {
                        return null;
                      }
                    }),
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, right: 0),
                    child: InkWell(
                      child: Text('Forgot ID?',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: CupertinoColors.white)),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 0),
                    child: Text('Password',
                        style: TextStyle(
                            fontSize: 18, color: CupertinoColors.white)),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: CupertinoColors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(),
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 0, bottom: 0, left: 10, right: 10),
                        suffixIcon: IconButton(
                          hoverColor: Colors.transparent,
                          icon: isPasswordVissible
                              ? const Tooltip(
                                  message: 'show characters',
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.white),
                                  child: Text(
                                    'Show',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        color: CupertinoColors.systemBlue),
                                  ),
                                )
                              : const Tooltip(
                                  message: 'hide characters',
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      color: CupertinoColors.white),
                                  child: Text(
                                    'Hide',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        color: CupertinoColors.systemBlue),
                                  ),
                                ),
                          onPressed: () => setState(
                              () => isPasswordVissible = !isPasswordVissible),
                        ),
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
                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, right: 0),
                    child: Text('Forgot Password?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: CupertinoColors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      FutureBuilder(
                          future:
                              Database(pass: psswd.text, username: user.text)
                                  .getinfo(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return const ScaffoldMessenger(
                                  child: SnackBar(
                                      content: Text('you have passed'),
                                      backgroundColor: Colors.red));
                            } else {
                              return const CircularProgressIndicator();
                            }
                          });

                      if (formkey.currentState!.validate()) {
                        debugPrint(
                            'User ID:${user.text} Password:${psswd.text}');

                        // final User? user = await _auth.emailPasswordSignIn(
                        //       email: user.text, password: psswd.text);
                      }

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
                  height: 40,
                ),
                const Text('New User?',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        color: CupertinoColors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
