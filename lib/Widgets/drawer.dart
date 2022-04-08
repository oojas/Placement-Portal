import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Text("ojas"),
            Text("ojas"),
            Text("ojas"),
            Text("ojas"),
          ],
        ),
      ),
    );
  }
}
