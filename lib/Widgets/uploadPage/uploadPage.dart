import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './uploadPage_pm.dart';

// Copy the line below and add as a child where you want to use UploadPage Widget
// ChangeNotifierProvider(create:(context)=>UploadPagePm(),child: UploadPage())

class UploadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UploadPagePm uploadPagePm = Provider.of<UploadPagePm>(context);
    return Scaffold(
        appBar: AppBar(title: Text("UploadPage"), centerTitle: true));
  }
}
