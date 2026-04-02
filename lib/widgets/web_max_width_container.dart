import 'package:flutter/material.dart';

class WebMaxWidthContainer extends StatelessWidget {
  final Widget child;
  
  const WebMaxWidthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: child,
      ),
    );
  }
}
