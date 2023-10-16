import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/constants.dart';
import '../constants/routes.dart';

class SeasonView extends StatefulWidget {
  const SeasonView({super.key});

  @override
  State<SeasonView> createState() => _SeasonViewState();
}

class _SeasonViewState extends State<SeasonView> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final _future = Supabase.instance.client
        .from('seasons')
        .select<List<Map<String, dynamic>>>()
        .eq('competition_id', arguments['leagueId'])
        .order('season_name');

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['leagueName']),
        toolbarHeight: height,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final seasons = snapshot.data!;
            return ListView.builder(
              itemCount: seasons.length,
              itemBuilder: ((context, index) {
                final season = seasons[index];
                return SeasonCard(
                  seasonId: season['season_id'].toString(),
                  seasonName: season['season_name'],
                  competitionId: season['competition_id'].toString(),
                  leagueName: arguments['leagueName'],
                );
              }),
            );
          }),
    );
  }
}

class SeasonCard extends StatelessWidget {
  final String seasonName;
  final String seasonId;
  final String competitionId;
  final String leagueName;

  const SeasonCard({
    super.key,
    required this.seasonName,
    required this.seasonId,
    required this.competitionId,
    required this.leagueName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        matchesRoute,
        arguments: {
          'seasonId': seasonId,
          'competitionId': competitionId,
          'seasonName': seasonName,
          'leagueName': leagueName
        },
      ),
      child: Center(
        child: Card(
          child: SizedBox(
            width: 300,
            height: 100,
            child: Center(
              child: Text(
                seasonName,
                style: const TextStyle(fontSize: 35),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
