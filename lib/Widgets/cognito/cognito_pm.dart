import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cognito_plugin/flutter_cognito_plugin.dart';

class CognitoPm extends ChangeNotifier {
  BuildContext context;
  var returnValue;
  UserState userState;
  double progress;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final attrsController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmationCodeController = TextEditingController();

  CognitoPm(this.context) {
    doLoad();
    Cognito.registerCallback((value) {
      userState = value;
      _notify();
    });
  }

  Future<void> doLoad() async {
    var value;
    try {
      value = await Cognito.initialize();
    } catch (e, trace) {
      print(e);
      print(trace);
      returnValue = e;
      progress = -1;
      return;
    }
    progress = -1;
    userState = value;
    _notify();
  }

  onPressWrapper(fn) {
    wrapper() async {
      progress = null;
      String value;
      try {
        value = (await fn()).toString();
      } catch (e, _) {
        value = e.toString();
      } finally {
        progress = -1;
      }
      returnValue = value;
      _notify();
    }
    return wrapper;
  }

  onsignUp() {
    return onPressWrapper(() {
      final attrs = attrsController.text;
      return Cognito.signUp(
        usernameController.text,
        passwordController.text,
        attrs.isEmpty ? null : Map<String, String>.from(jsonDecode(attrs)),
      );
    });
  }

  confirmSignUp() {
    return onPressWrapper(() {
      return Cognito.confirmSignUp(
        usernameController.text,
        confirmationCodeController.text,
      );
    });
  }

  resendSignUp() {
    return onPressWrapper(() {
      return Cognito.resendSignUp(usernameController.text);
    });
  }

  signIn() {
    return onPressWrapper(() {
      return Cognito.signIn(
        usernameController.text,
        passwordController.text,
      );
    });
  }

  confirmSignIn() {
    return onPressWrapper(() {
      return Cognito.confirmSignIn(confirmationCodeController.text);
    });
  }

  signOut() {
    return onPressWrapper(() {
      return Cognito.signOut();
    });
  }

  showSignIn() {
    return onPressWrapper(() {
      return Cognito.showSignIn(
        identityProvider: "google",
        scopes: ["email", "openid"],
      );
    });
  }

  forgotPassowrd() {
    return onPressWrapper(() {
      return Cognito.forgotPassword(usernameController.text);
    });
  }

  confirmForgotPassword() {
    return onPressWrapper(() {
      return Cognito.confirmForgotPassword(
        usernameController.text,
        newPasswordController.text,
        confirmationCodeController.text,
      );
    });
  }

  getCreds() {
    return onPressWrapper(() {
      return Cognito.getCredentials();
    });
  }

  getTokens() {
    return onPressWrapper(() {
      return Cognito.getTokens();
    });
  }

  getIdentityId() {
    return onPressWrapper(() {
      return Cognito.getIdentityId();
    });
  }

  isSignedIn() {
    return onPressWrapper(() {
      return Cognito.isSignedIn();
    });
  }

  getUsername() {
    return onPressWrapper(() {
      return Cognito.getUsername();
    });
  }

  _notify() {
    try {
      this.notifyListeners();
    } catch (e) {
      print("Error while notify in Cognito");
    }
  }
}
