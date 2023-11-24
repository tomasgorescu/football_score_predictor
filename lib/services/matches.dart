import 'package:supabase_flutter/supabase_flutter.dart';

class MatchesModel {
  Future<List<Map<String, dynamic>>> getMatches(
      String season, String? round) async {
    dynamic matches = await Supabase.instance.client
        .from('br_fat_matches')
        .select<List<Map<String, dynamic>>>(
            'id_partida, time_mandante, time_visitante, gols_mandante, gols_visitante')
        .eq('ano_campeonato', 2023)
        .eq('rodada', 5);
    return matches;
  }
}
