// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// ignore: must_be_immutable
class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  String title;
  Function()? onPressed;
  List<Widget>? actions;
  AppBarComponent({
    Key? key,
    this.onPressed,
    this.actions,
    this.title = '-',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      /*leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          /* if (onPressed != null) {
            await onPressed!();
          } */

          Modular.to.pop();
        },
      ),*/
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(45);
}
