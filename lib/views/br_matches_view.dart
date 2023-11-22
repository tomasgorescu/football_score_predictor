import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import '../utilites/app_bar_drawer.dart';
import '../utilites/match_card.dart';

class BrMatchesView extends StatefulWidget {
  const BrMatchesView({super.key});

  @override
  State<BrMatchesView> createState() => _BrMatchesViewState();
}

class _BrMatchesViewState extends State<BrMatchesView> {
  @override
  Widget build(BuildContext context) {
    int currentRound = 5;
    int currentSeason = 2023;

    final _future = Supabase.instance.client
        .from('br_fat_matches')
        .select<List<Map<String, dynamic>>>(
            'time_mandante, time_visitante, gols_mandante, gols_visitante')
        .eq('ano_campeonato', currentSeason)
        .eq('rodada', currentRound);
    return Scaffold(
      appBar: AppBar(
        title: Text('Brasileirão $currentSeason'),
        toolbarHeight: height,
      ),
      drawer: const AppBarDrawer(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final matches = snapshot.data!;
          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: ((context, index) {
              final match = matches[index];
              return MatchCard(
                awayTeamImage: Image.asset(
                    'assets/images/clubs/${match['time_visitante']}.png'),
                awayTeamScore: match['gols_visitante'].toString(),
                awayTeamName: match['time_visitante'],
                homeTeamImage: Image.asset(
                  ('assets/images/clubs/${match['time_mandante']}.png'),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/images/clubs/placeholder.jpeg",
                    );
                  },
                ),
                homeTeamScore: match['gols_mandante'].toString(),
                homeTeamName: match['time_mandante'],
              );
            }),
          );
        },
      ),
    );
  }
}
