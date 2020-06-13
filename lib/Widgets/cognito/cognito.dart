import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './cognito_pm.dart';

class CognitoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CognitoPm cognitoPm = Provider.of<CognitoPm>(context);

    Widget buildChildren(List<List<Widget>> children) {
      List<Widget> c = children.map((item) {
        return Wrap(
          children: item,
          spacing: 10,
          alignment: WrapAlignment.center,
        );
      }).toList();
      return ListView.separated(
        itemCount: children.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: c[index],
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    }

    utils() {
      return [
        RaisedButton(
          child: Text("getUsername()"),
          onPressed: cognitoPm.getUsername,
        ),
        RaisedButton(
          child: Text("isSignedIn()"),
          onPressed: cognitoPm.isSignedIn,
        ),
        RaisedButton(
          child: Text("getIdentityId()"),
          onPressed: cognitoPm.getIdentityId,
        ),
        RaisedButton(
          child: Text("getTokens()"),
          onPressed: cognitoPm.getTokens,
        ),
        RaisedButton(
          child: Text('getCredentials()'),
          onPressed: cognitoPm.getCreds,
        ),
      ];
    }

    textFields() {
      return [
        [
          TextField(
            decoration: InputDecoration(labelText: 'username'),
            controller: cognitoPm.usernameController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'password'),
            controller: cognitoPm.passwordController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'userAttributes'),
            controller: cognitoPm.attrsController,
          )
        ],
        [
          TextField(
            decoration: InputDecoration(labelText: 'confirmationCode'),
            controller: cognitoPm.confirmationCodeController,
          ),
        ],
        [
          TextField(
            decoration: InputDecoration(labelText: 'newPassword'),
            controller: cognitoPm.newPasswordController,
          ),
        ],
      ];
    }

    signUp() {
      return [
        RaisedButton(
          child: Text("signUp(username, password)"),
          onPressed: cognitoPm.onsignUp,
        ),
        RaisedButton(
          child: Text("confirmSignUp(username, confirmationCode)"),
          onPressed: cognitoPm.confirmSignUp,
        ),
        RaisedButton(
          child: Text("resendSignUp(username)"),
          onPressed: cognitoPm.resendSignUp,
        )
      ];
    }

    signIn() {
      return [
        RaisedButton(
            child: Text("signIn(username, password)"),
            onPressed: cognitoPm.signIn),
        RaisedButton(
            child: Text("confirmSignIn(confirmationCode)"),
            onPressed: cognitoPm.confirmSignIn),
        RaisedButton(
          child: Text("signOut()"),
          onPressed: cognitoPm.signOut,
        ),
        RaisedButton(
          child: Text("showSignIn()"),
          onPressed: cognitoPm.showSignIn,
        ),
      ];
    }

    forgotPassword() {
      return [
        RaisedButton(
          child: Text("forgotPassword(username)"),
          onPressed: cognitoPm.forgotPassowrd,
        ),
        RaisedButton(
          child: Text(
            "confirmForgotPassword(username, newPassword, confirmationCode)",
          ),
          onPressed: cognitoPm.confirmForgotPassword,
        )
      ];
    }

    List<Widget> buildReturnValue() {
      return [
        SelectableText(
          cognitoPm.userState?.toString() ?? "UserState will appear here",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        Divider(),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("AWS Cognito"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: buildChildren(
              <List<Widget>>[
                buildReturnValue(),
                ...textFields(),
                signUp(),
                signIn(),
                forgotPassword(),
                utils(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
