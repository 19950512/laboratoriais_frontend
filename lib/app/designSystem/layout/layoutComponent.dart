// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

import 'appbarComponent.dart';
import 'drawermenuComponent.dart';
import 'floatActionButtonComponent.dart';

class LayoutComponent extends StatelessWidget {
  late String title;
  late Widget body;
  late bool esconderDrawer;
  late List<Widget>? actions = [Container()];
  LayoutComponent({
    Key? key,
    required this.title,
    required this.body,
    this.esconderDrawer = false,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthMax = MediaQuery.of(context).size.width;

    if (widthMax > 1024) {
      widthMax = 1024;
    }

    return Scaffold(
      appBar: AppBarComponent(
        title: title,
        actions: actions ?? [Container()],
      ),
      drawer: esconderDrawer ? null : DrawerMenuComponent(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: widthMax,
          child: body,
        ),
      ),
      floatingActionButton: const FloatActionButtonComponent(),
    );
  }
}
