import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utilites/app_bar_drawer.dart';
import '../utilites/matches_list.dart';

class PaginatedMatchesView extends StatelessWidget {
  const PaginatedMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Score Predictor'),
          toolbarHeight: height,
        ),
        drawer: const AppBarDrawer(),
        body: const MatchesList());
  }
}