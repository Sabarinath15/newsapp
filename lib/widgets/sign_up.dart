import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  bool isLoading = false;

  String email = '';
  String password = '';

  Future<void> registerUser(String email, String password) async {
    var url = Uri.https('nodejs-register-login-app.herokuapp.com', '');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
        'passwordConf': password,
      },
    );
    if (response.statusCode == 200) {
      //Navigator.pushNamed(context, NewsPage.routname);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registered successfully!')));
    }
    //print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          'Sign Up',
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
                  key: _passwordFieldKey,
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
                    hintText: 'Re-enter Password:',
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
                      return 'Please re-enter the password';
                    }
                    if (_passwordFieldKey.currentState!.value != value) {
                      return 'Password do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
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
                      registerUser(email, password).then((value) => {
                            setState(() {
                              isLoading = false;
                            })
                          });
                      //Navigator.of(context).pushNamed(NewsPage.routname);
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
                          'Sign Up',
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
          height: 15,
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
                'Or Sign Up With',
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
          height: 10,
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
