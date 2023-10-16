import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/constants.dart';

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
            'date, home_team_id, home_team_name, away_team_id, away_team_name, home_score, away_score')
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

class MatchCard extends StatelessWidget {
  final Image awayTeamImage;
  final Image homeTeamImage;
  final String? homeTeamScore;
  final String? awayTeamScore;
  final String homeTeamName;
  final String awayTeamName;

  const MatchCard({
    super.key,
    required this.awayTeamImage,
    required this.homeTeamImage,
    required this.homeTeamName,
    required this.awayTeamName,
    this.homeTeamScore,
    this.awayTeamScore,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          width: 300,
          height: 100,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: homeTeamImage,
                    ),
                    SizedBox(
                      width: 50,
                      height: 30,
                      child: Text(
                        homeTeamName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Text(
                  homeTeamScore ?? '',
                  style: const TextStyle(fontSize: 35),
                ),
                const Text('X'),
                Text(
                  awayTeamScore ?? '',
                  style: const TextStyle(fontSize: 35),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: awayTeamImage,
                    ),
                    SizedBox(
                      width: 50,
                      child: Text(
                        awayTeamName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
