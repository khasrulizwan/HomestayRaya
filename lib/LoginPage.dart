import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kelasmbl/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double screenHeight, screenWidth;
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  bool _isChecked = false;
  get cursor => null;

  get height => null;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
              elevation: 8,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.isEmpty ||
                              !val.contains("@") ||
                              !val.contains(".")
                          ? "Enter valid email"
                          : null,
                      focusNode: focus,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus1);
                      },
                      controller: _emailditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(),
                          labelText: 'Email',
                          icon: FaIcon(FontAwesomeIcons.phone),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          )),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (val) => validatePassword(val.toString()),
                      focusNode: focus1,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus2);
                      },
                      controller: _passEditingController,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(),
                          labelText: 'Password',
                          icon: FaIcon(FontAwesomeIcons.lock),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          )),
                      obscureText: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                            value: _isChecked,
                            onChanged: (final bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            }),
                        const Flexible(
                            child: Text(
                          'Remember me',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minWidth: 115,
                          height: 50,
                          elevation: 10,
                          onPressed: _loginUser,
                          color: Theme.of(context).colorScheme.primary,
                          child: const Text('Login'),
                        ),
                      ],
                    )
                  ]),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Register new account",
                  style: TextStyle(fontSize: 16.0)),
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RegisterPage()),
                  )
                },
                child: const Text(
                  " Click here",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),

        ]),
      ),
    );
  }

  void _loginUser() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
  }

  validatePassword(String string) {}
}
