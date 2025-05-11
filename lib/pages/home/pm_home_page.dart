import 'package:flutter/material.dart';
import 'package:play_music/core/extension/pm_string.dart';
import 'package:play_music/widget/pm_appbar/pm_appbar_view.dart';

class PmHomePage extends StatelessWidget {
  static const String routeName = "/";

  const PmHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PmAppbarPage(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "issue".i18n,
            style: const TextStyle(
                color: Colors.red, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          TextButton(
              child: const Text("页面跳转测试"),
              onPressed: () {
                Navigator.of(context).pushNamed("routeName");
              }),
          TextButton(
              child: const Text("选择时间"),
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(3000));
              }),
          TextButton(
              child: const Text("跳转测试"),
              onPressed: () {
                // Navigator.of(context).pushNamed(PmHome.routeName);
              }),
        ],
      )),
    );
  }
}
