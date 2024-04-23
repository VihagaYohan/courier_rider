import 'package:flutter/material.dart';

class UIContainer extends StatelessWidget {
  final Widget children;
  final PreferredSizeWidget? appbar;
  final bool showAppBar;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final bool? isShowFab;
  final Widget? Fab;

  const UIContainer(
      {super.key,
      required this.children,
      this.appbar,
      this.showAppBar = false,
      this.paddingTop = 10,
      this.paddingBottom = 10,
      this.paddingLeft = 20,
      this.paddingRight = 20,
      this.isShowFab = false,
      this.Fab});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: showAppBar ? appbar : null,
      body: Container(
        padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            bottom: paddingBottom,
            top: paddingTop),
        child: children,
      ),
      floatingActionButton: isShowFab == true ? Fab : null,
    ));
  }
}
