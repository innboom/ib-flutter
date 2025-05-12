import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ib_appbar_bloc.dart';
import 'ib_appbar_event.dart';
import 'ib_appbar_state.dart';

class IbAppbarPage extends StatefulWidget {
  final Widget child;
  final Widget? title; // 这里是可选的

  // 构造函数修改为命名参数
  const IbAppbarPage(
      {Key? key, required this.child, this.title = const Text("MUSICE")})
      : super(key: key);

  @override
  _IbAppbarPageState createState() => _IbAppbarPageState();
}

class _IbAppbarPageState extends State<IbAppbarPage> {
  // 创建一个 GlobalKey 用于控制 Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => IbAppbarBloc()..add(InitEvent()),
      child: Scaffold(
        key: _scaffoldKey, // 使用 GlobalKey 给 Scaffold 添加一个 key
        appBar: _buildAppBar(context),
        body: widget.child, // 显示传递进来的页面
        endDrawer: _buildDrawer(context), // 使用 endDrawer 而不是 drawer
      ),
    );
  }

  // 构建 AppBar 并为右上角添加按钮打开抽屉
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: widget.title,
      actions: [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // 使用 GlobalKey 控制 Scaffold 打开右侧抽屉
            _scaffoldKey.currentState?.openEndDrawer();
          },
        ),
      ],
    );
  }

  // 构建右侧抽屉
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          DrawerHeader(
            child: Text('右侧抽屉'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Text("你好")
        ],
      ),
    );
  }
}
