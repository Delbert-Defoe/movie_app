import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieapp/screens/authenticate_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movieapp/screens/home_screen.dart';
import 'package:movieapp/services/database.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class LocalUser {
  LocalUser._privateConstructor();
  static final LocalUser instance = LocalUser._privateConstructor();
  static LocalUser _localUser;

  String username;
  dynamic points;
  List<String> preferences;
  String uid;
  static User _firebaseUser;

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final DatabaseService _databaseService = DatabaseService();

//Stream listener which determines user login state
  Stream<LocalUser> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user != null) {
        uid = user.uid;
      }
      return _userFromFirebaseUser(user);
    });
  }

//Get UID
  Future getCurrentUser() async {
    String userID = await _firebaseAuth.currentUser.uid;
    return userID;
  }

//custom user object
  LocalUser _userFromFirebaseUser(User user) {
    if (user != null) {
      _firebaseUser = user;
      getUserData(user.uid).then((doc) => {
            if (doc == null)
              {username = null, preferences = null, points = null}
            else
              {
                this.username = doc['name'],
                this.preferences = List<String>.from(doc['preferences']),
                this.points = doc['points']
              }
          });
      return LocalUser.instance;
    } else if (user == null) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      var response = await _databaseService.userCollection.doc(uid).get();

      if (response.exists) {
        return response.data();
      } else {
        return null;
      }
    } catch (e) {}
  }

//sign-in anonymously function
  Future singInAnonymously() async {
    try {
      UserCredential _result = await _firebaseAuth.signInAnonymously();
      User user = _result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign-in with Google
  Future signInWithGoogle() async {
    try {
      GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleSignInAuthentication =
          await _googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleSignInAuthentication.idToken,
          accessToken: _googleSignInAuthentication.accessToken);

      UserCredential _result =
          await _firebaseAuth.signInWithCredential(credential);

      User user = _result.user;

      //  await DatabaseService(uid: user.uid)
      //      .updateUserData(user.displayName, ['none'], 5);

      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

//facebook sign in
/*  Future signInWithFacebook() async {
    FacebookLoginResult result =
        await _facebookLogin.logIn(['email', 'first_name', 'last_name']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final credential =
            await FacebookAuthProvider.getCredential(accessToken: token);
        AuthResult _authResult =
            await _firebaseAuth.signInWithCredential(credential);
        FirebaseUser user = _authResult.user;

        return _userFromFirebaseUser(user);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancelled');
        break;
      case FacebookLoginStatus.error:
        print('error');
        break;
    }
  }
*/
  //Sign out
  Future signout() async {
    try {
      if (_firebaseUser.providerData[0].providerId == 'google.com') {
        _googleSignIn.disconnect();
        _firebaseAuth.signOut();
      } else {
        return await _firebaseAuth.signOut();
      }
    } catch (e) {
      print(e.toString());
    }
  }
  /* 
 Create user with email and password -->
 Future<String> creatUserWithEmailAndPassword(
      String email, String password, String username) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await updateUserName(username, authResult.user);
    return authResult.user.uid;
  }
  */

  // Update the username

  /* Future updateUserData(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload(); 
  } */
}
