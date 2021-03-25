import 'package:flutter/material.dart';

class SafeBottom extends StatelessWidget {
  final Color background;

  const SafeBottom({Key key, this.background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.background ?? Colors.white,
      height: MediaQuery.of(context).padding.bottom,
    );
  }
}
