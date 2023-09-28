import 'package:flutter/material.dart';

import '../constants/routes.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(matchesRoute),
      child: Center(
        child: Card(
          child: SizedBox(
            width: 300,
            height: 100,
            child: child,
          ),
        ),
      ),
    );
  }
}
