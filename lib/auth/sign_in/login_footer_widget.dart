import 'package:flutter/material.dart';


import '../constants/image_strings.dart';
import '../constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('OR'),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(
              image: AssetImage(googleLogo),
              width: 20,
            ),
            onPressed: () {},
            label: Text(signInWithGoogle),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/signup'),
          child: const Text.rich(
            TextSpan(
              text: dontHaveAnAccount,
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(text: signUp, style: TextStyle(color: Colors.blue))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
