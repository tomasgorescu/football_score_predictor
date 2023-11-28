import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/match.dart';

class MatchRepository with ChangeNotifier {
  int resultsFetched = 0;
  static const perPage = 30;
  final List<Match> _matches = [];

  List<Match> get matches => _matches;

  getMatches() async {
    final result = await Supabase.instance.client
        .from('br_fat_matches')
        .select<List<Map<String, dynamic>>>('*')
        .eq('ano_campeonato', 2023)
        .range(resultsFetched, resultsFetched + perPage)
        .order('data', ascending: false);
    for (var i = 0; i < result.length; i++) {
      print(result[i]);
      _matches.add(Match.fromMap(result[i]));
    }
    resultsFetched += result.length;
    notifyListeners();
  }

  getMatchesBySeason(int seasonId) async {
    final result = await Supabase.instance.client
        .from('br_fat_matches')
        .select<List<Map<String, dynamic>>>('*')
        .eq('ano_campeonato', seasonId)
        .range(resultsFetched, resultsFetched + perPage)
        .order('data', ascending: false);
    for (var i = 0; i < result.length; i++) {
      print(result[i]);
      _matches.add(Match.fromMap(result[i]));
    }
    resultsFetched += result.length;
    notifyListeners();
  }
}
