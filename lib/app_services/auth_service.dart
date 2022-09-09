import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sovtech_ecommerce/app_providers/cart_provider.dart';
import 'package:sovtech_ecommerce/app_providers/product_provider.dart';
import 'package:sovtech_ecommerce/app_views/homePageView.dart';

import '../app_constants/error_screen.dart';
import '../app_views/signInView.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

handleAuth() {
  return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomePageView();
        } else if (snapshot.hasError) {
          ErrorScreen(
            error: snapshot.error.toString(),
          );
        }
        return const SignInView();
      });
}

Future<User?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    //SIGNING IN WITH CREDENTIAL & MAKING A USER IN FIREBASE  AND GETTING USER CLASS
    final userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    //CHECKING IS ON
    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);

    final User? currentUser = await _auth.currentUser;
    assert(currentUser!.uid == user!.uid);
    return user;
  } catch (e) {
    ErrorScreen(error: e.toString());
  }
}

Future signOut() async {
  await googleSignIn.signOut();
  await _auth.signOut();
}
