import 'package:flutter/material.dart';

//widgets
import '../widgets/sign_up.dart';
import '../widgets/sign_in.dart';

class SignInSignUp extends StatefulWidget {
  const SignInSignUp({Key? key}) : super(key: key);

  @override
  _SignInSignUpState createState() => _SignInSignUpState();
}

class _SignInSignUpState extends State<SignInSignUp> {
  bool signup = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        signup ? SignUp() : SignIn(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            signup
                ? const Text(
                    'Have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                : const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
            TextButton(
              onPressed: () {
                setState(() {
                  signup = !signup;
                });
              },
              child: signup
                  ? const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    )
                  : const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
            ),
          ],
        )
      ],
    );
  }
}
