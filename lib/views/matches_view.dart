import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';
import '../utilites/match_card.dart';

class MatchesView extends StatefulWidget {
  const MatchesView({super.key});

  @override
  State<MatchesView> createState() => _MatchesViewState();
}

class _MatchesViewState extends State<MatchesView> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final _future = Supabase.instance.client
        .from('fat_matches')
        .select<List<Map<String, dynamic>>>(
            'id, date, home_team_id, home_team_name, away_team_id, away_team_name, home_score, away_score')
        .eq('competition_id', arguments['competitionId'])
        .eq('season_id', arguments['seasonId'])
        .order('date');

    return Scaffold(
      appBar: AppBar(
        title: Text('${arguments['leagueName']} ${arguments['seasonName']}'),
        toolbarHeight: height,
      ),
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
                matchId: match['id'].toString(),
                awayTeamImage:
                    Image.asset('assets/images/clubs/america_mineiro.png'),
                awayTeamScore: match['away_score'].toString(),
                awayTeamName: match['away_team_name'],
                homeTeamImage:
                    Image.asset(('assets/images/clubs/corinthians.png')),
                homeTeamScore: match['home_score'].toString(),
                homeTeamName: match['home_team_name'],
              );
            }),
          );
        },
      ),
    );
  }
}
