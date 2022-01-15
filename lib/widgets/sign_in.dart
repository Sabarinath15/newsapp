import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//
import '../Screens/news_page.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  String email = '';
  String password = '';

  Future<void> loginuser(String email, String password) async {
    var url = Uri.https('nodejs-register-login-app.herokuapp.com', '/login');
    final respose = await http.post(url, body: {
      'email': email,
      'password': password,
    });
    final extracted = jsonDecode(respose.body);
    if (respose.statusCode == 200) {
      if (extracted['Success'] == 'Success!') {
        Navigator.of(context).pushNamed(NewsPage.routname);
      } else if (extracted['Success'] == 'Wrong password!') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong password!')));
      } else if (extracted['Success'] == 'This Email Is not regestered!') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This Email Is not regestered!')));
      }
    }
    //print(extracted['Success']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          'Sign In',
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Form(
          key: _formkey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email :',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    fillColor: Colors.brown[200],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    email = newValue!;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password :',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    fillColor: Colors.brown[200],
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    if (value.length < 8) {
                      return 'Password length must be 8 digits long';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    password = newValue!;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 15,
                    ),
                    primary: Colors.lightBlue[400],
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });
                      loginuser(email, password).then((value) => {
                            setState(() {
                              isLoading = false;
                            })
                          });
                    }
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  height: 2,
                  thickness: 2,
                  indent: 15,
                  endIndent: 15,
                  color: Colors.grey[350],
                ),
              ),
              const Text(
                'Or Sign In With',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Divider(
                  height: 2,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.grey[350],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
              ),
              onPressed: () {},
              child: Image.asset(
                'assets/image/google.png',
                width: 60,
                height: 60,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: const CircleBorder(),
              ),
              onPressed: () {},
              child: Image.asset(
                'assets/image/Facebook.png',
                width: 45,
                height: 45,
              ),
            ),
          ],
        )
      ],
    );
  }
}
