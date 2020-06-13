import 'package:aws_cognito/Widgets/cognito/cognito.dart';
import 'package:aws_cognito/Widgets/cognito/cognito_pm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aws_cognito/Constants/routes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RouteNames.cognito: (context) => ChangeNotifierProvider(
              create: (context) => CognitoPm(context),
              child: CognitoWidget(),
            ),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(),
      ),
      initialRoute: RouteNames.cognito,
    );
  }
}
