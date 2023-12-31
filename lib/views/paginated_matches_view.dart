import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utilites/app_bar_drawer.dart';
import '../utilites/matches_list.dart';

class PaginatedMatchesView extends StatelessWidget {
  const PaginatedMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final seasonId = int.parse(arguments['seasonId'] ?? '2023');
    final seasonName = arguments['leagueName'] ?? 'Brasileirão';
    return Scaffold(
        appBar: AppBar(
          title: Text(seasonName),
          toolbarHeight: height,
        ),
        drawer: const AppBarDrawer(),
        body: MatchesList(seasonId: seasonId));
  }
}
