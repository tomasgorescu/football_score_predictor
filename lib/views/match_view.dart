import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/constants.dart';
import '../utilites/app_bar_drawer.dart';
import '../utilites/match_card.dart';

class MatchView extends StatefulWidget {
  const MatchView({super.key});

  @override
  State<MatchView> createState() => _MatchViewState();
}

class _MatchViewState extends State<MatchView> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final _future = Supabase.instance.client
        .from('br_fat_matches')
        .select<List<Map<String, dynamic>>>('*')
        .eq('id_partida', arguments['matchId']);
    return Scaffold(
      appBar: AppBar(
        title: Text('${arguments['homeName']} X ${arguments['awayName']}'),
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
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            ('assets/images/clubs/${match['time_mandante']}.png'),
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/clubs/placeholder.jpeg",
                                height: 60,
                              );
                            },
                            height: 60,
                          ),
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: Text(
                              arguments['homeName'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        match['gols_mandante'] ?? '',
                        style: const TextStyle(fontSize: 35),
                      ),
                      const Text('X'),
                      Text(
                        match['gols_visitante'] ?? '',
                        style: const TextStyle(fontSize: 35),
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/clubs/${match['time_visitante']}.png',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/clubs/placeholder.jpeg",
                                height: 60,
                              );
                            },
                            height: 60,
                          ),
                          SizedBox(
                            width: 50,
                            height: 30,
                            child: Text(
                              arguments['awayName'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: false,
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text("Data: ${match['data']}"),
                  Text("Estádio: ${match['estadio']}"),
                  Text("Árbitro: ${match['arbitro']}"),
                  Text("Público: ${match['publico']}"),
                ],
              );
            }),
          );
        },
      ),
    );
  }
}
