// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kelasmbl/LoginPage.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

void main() => runApp(const RegisterPage());

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
    loadEula();
  }

  late double screenHeight, screenWidth;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  bool _isChecked = false;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String eula = "";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Card(
          elevation: 10,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const Text(
                    "Register New Account",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (val) => val!.isEmpty || (val.length < 3)
                        ? "name must be longer than 3"
                        : null,
                    onFieldSubmitted: (v) {
                      FocusScope.of(context).requestFocus(focus);
                    },
                    controller: _nameEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(),
                        icon: FaIcon(FontAwesomeIcons.person),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        )),
                  ),
                  TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty ||
                              !val.contains("@") ||
                              !val.contains(".")
                          ? "enter a valid email"
                          : null,
                      focusNode: focus,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus1);
                      },
                      controller: _emailditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ))),
                  TextFormField(
                    controller: _passEditingController,
                    textInputAction: TextInputAction.next,
                    focusNode: focus1,
                    validator: (val) => validatePassword(val.toString()),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      icon: const Icon(Icons.lock),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: _passwordVisible,
                  ),
                  TextFormField(
                    style: const TextStyle(),
                    textInputAction: TextInputAction.done,
                    focusNode: focus2,
                    validator: (val) {
                      validatePassword(val.toString());
                      if (val != _passEditingController.text) {
                        return "password do not match";
                      } else {
                        return null;
                      }
                    },
                    controller: _pass2EditingController,
                    decoration: InputDecoration(
                      labelText: 'Re‐enter Password',
                      labelStyle: TextStyle(),
                      icon: Icon(Icons.lock),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: _passwordVisible,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: showEULA,
                          child: const Text('Agree with terms',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 115,
                        height: 50,
                        elevation: 10,
                        onPressed: _RegisterAccount,
                        color: Theme.of(context).colorScheme.primary,
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Already Register? ",
                style: TextStyle(
                  fontSize: 16.0,
                )),
            GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()),
                )
              },
              child: const Text(
                "Login here",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: _RegisterAccount,
          child: const Text(
            "Back to Home",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    ));
  }

  loadEula() async {
    eula = await rootBundle.loadString('assets/eula.txt');
    print(eula);
  }

  showEULA() {
    loadEula();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "EULA",
            style: TextStyle(color: Colors.black),
          ),
          content: SizedBox(
            height: screenHeight / 1.5,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                        ),
                        text: eula),
                  )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _RegisterAccount() {
    String _name = _nameEditingController.text;
    String _email = _emailditingController.text;
    String _passa = _passEditingController.text;
    String _passb = _pass2EditingController.text;

    if (!_formKey.currentState!.validate() && _isChecked) {
      Fluttertoast.showToast(
          msg: "Please complete the registration form first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept the terms and conditions",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (_passa != _passb) {
      Fluttertoast.showToast(
          msg: "Please check your password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _registerUser(_name, _email, _passa);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  void _registerUser(String name, String email, String pass) {
    try {
      http.post(Uri.parse("${Config.SERVER}/php/_registerUser.php"), body: {
        "name": name,
        "email": email,
        "password": pass,
        "register": "register "
      }).then((response){
        //print(response);
        var jsonResponse = jsonDecode(response.body);
        if (response.statusCode == 200 && jsonResponse['status'] == "success") {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          return;
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
                Navigator.push(context,
            MaterialPageRoute(builder: (content) => const LoginPage()));
          return;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
