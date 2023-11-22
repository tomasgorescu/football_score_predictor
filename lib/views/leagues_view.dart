import 'package:flutter/material.dart';
import 'package:football_score_predictor/utilites/app_bar_drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/constants.dart';
import '../utilites/league_card.dart';

final supabase = Supabase.instance.client;

class LeaguesView extends StatefulWidget {
  const LeaguesView({super.key});

  @override
  State<LeaguesView> createState() => _LeaguesViewState();
}

class _LeaguesViewState extends State<LeaguesView> {
  final _future =
      supabase.from('competitions').select<List<Map<String, dynamic>>>();
  dynamic leagues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Predictor'),
        toolbarHeight: height,
      ),
      drawer: const AppBarDrawer(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final leagues = snapshot.data!;
            return ListView.builder(
              itemCount: leagues.length,
              itemBuilder: ((context, index) {
                final league = leagues[index];
                return LeagueCard(
                  leagueId: league['competition_id'].toString(),
                  leagueName: league['competition_name'].toString(),
                  child: Image.network(
                    league['competition_image'],
                  ),
                );
              }),
            );
          }),
    );
  }
}
