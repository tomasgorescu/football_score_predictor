class Match {
  String homeTeamName;
  String homeTeamImage;
  String homeTeamScore;
  String awayTeamName;
  String awayTeamImage;
  String awayTeamScore;
  String matchId;
  String? round;

  Match(
      {required this.homeTeamName,
      required this.homeTeamImage,
      required this.homeTeamScore,
      required this.awayTeamName,
      required this.awayTeamImage,
      required this.awayTeamScore,
      required this.matchId,
      this.round});

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      matchId: map['id_partida'].toString(),
      homeTeamName: map['time_mandante'],
      homeTeamImage: 'assets/images/clubs/${map['time_mandante']}.png',
      homeTeamScore: map['gols_mandante'].toString(),
      awayTeamName: map['time_visitante'],
      awayTeamImage: 'assets/images/clubs/${map['time_visitante']}.png',
      awayTeamScore: map['gols_visitante'].toString(),
      round: map['rodada'].toString(),
    );
  }
}
