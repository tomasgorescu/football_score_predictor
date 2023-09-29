import 'package:flutter/material.dart';

import '../constants/routes.dart';

class LeagueCard extends StatelessWidget {
  const LeagueCard({
    Key? key,
    required this.child,
    required this.leagueId,
    required this.leagueName,
  }) : super(key: key);

  final Widget child;
  final String leagueId;
  final String leagueName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        seasonsRoute,
        arguments: {'leagueId': leagueId, 'leagueName': leagueName},
      ),
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
