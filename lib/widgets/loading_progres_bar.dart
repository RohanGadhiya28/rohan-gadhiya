

import 'package:flutter/material.dart';

class LoadingProgressBar extends StatelessWidget {
  Color? color = Colors.white;
  double? width = 5.0;
  double? height = 5.0;

  LoadingProgressBar({super.key,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: width,
      height: height,
      child: const CircularProgressIndicator(),
    );
  }
}
