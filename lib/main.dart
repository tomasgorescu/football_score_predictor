import 'package:flutter/material.dart';
import 'package:football_score_predictor/views/leagues_view.dart';
import 'package:football_score_predictor/views/match_view.dart';
import 'package:football_score_predictor/views/paginated_matches_view.dart';
import 'package:football_score_predictor/views/seasons_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants/routes.dart';
import 'views/about_us_view.dart';
import 'views/matches_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: const String.fromEnvironment('supabaseUrl'),
    anonKey: const String.fromEnvironment('supabaseKey'),
  );
  runApp(MaterialApp(
    title: 'Mago das apostas',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const PaginatedMatchesView(),
    routes: {
      matchesRoute: (context) => const MatchesView(),
      seasonsRoute: (context) => const SeasonView(),
      leaguesRoute: (context) => const LeaguesView(),
      aboutUsRoute: (context) => const AboutUsView(),
      matchRoute: (context) => const MatchView(),
      paginatedMatchesRoute: (context) => const PaginatedMatchesView()
    },
  ));
}
