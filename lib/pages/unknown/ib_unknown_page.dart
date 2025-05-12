import 'package:flutter/material.dart';

class IbUnknownPage extends StatelessWidget {
  static const String routeName = "/unknown";

  const IbUnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("未知页面"),
      ),
      body: Center(
        child: Text("首页"),
      ),
    );
  }
}
