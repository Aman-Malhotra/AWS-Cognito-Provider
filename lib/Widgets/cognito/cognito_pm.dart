import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';

class CognitoPm extends ChangeNotifier {
  BuildContext context;

  UserState userState;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final attrsController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmationCodeController = TextEditingController();

  CognitoPm(this.context) {
    doLoad();
    Cognito.registerCallback((value) {
      userState = value;
    });
  }

  Future<void> doLoad() async {
    var value;
    value = await Cognito.initialize();
    userState = value;
  }

  onsignUp() {
    final attrs = attrsController.text;
    Cognito.signUp(
      usernameController.text,
      passwordController.text,
      attrs.isEmpty ? null : Map<String, String>.from(jsonDecode(attrs)),
    );
  }

  confirmSignUp() {
    Cognito.confirmSignUp(
      usernameController.text,
      confirmationCodeController.text,
    );
  }

  resendSignUp() {
    Cognito.resendSignUp(usernameController.text);
  }

  signIn() {
    Cognito.signIn(
      usernameController.text,
      passwordController.text,
    );
  }

  confirmSignIn() {
    Cognito.confirmSignIn(confirmationCodeController.text);
  }

  signOut() {
    Cognito.signOut();
  }

  showSignIn() {
    Cognito.showSignIn(
      identityProvider: "google",
      scopes: ["email", "openid"],
    );
  }

  forgotPassowrd() {
    Cognito.forgotPassword(usernameController.text);
  }

  confirmForgotPassword() {
    Cognito.confirmForgotPassword(
      usernameController.text,
      newPasswordController.text,
      confirmationCodeController.text,
    );
  }

  getCreds() {
    Cognito.getCredentials();
  }

  getTokens() {
    Cognito.getTokens();
  }

  getIdentityId() {
    Cognito.getIdentityId();
  }

  isSignedIn() {
    Cognito.isSignedIn();
  }

  getUsername() {
    Cognito.getUsername();
  }
}
