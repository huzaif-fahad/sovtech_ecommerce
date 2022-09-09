import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sovtech_ecommerce/app_widgets/customWidgets.dart.dart';

import '../app_services/auth_service.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: custom_Appbar('Sov Tech', Colors.lightBlue),
      ),
      body: signInBody(),
    );
  }

  signInBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
            ),
            GestureDetector(
              child: custom_Buttom(
                "Login With Google",
                Colors.lightBlueAccent,
                0.1,
              ),
              onTap: () {
                signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
