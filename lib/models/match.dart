class Match {
  String homeTeamName;
  String homeTeamImage;
  String homeTeamScore;
  String awayTeamName;
  String awayTeamImage;
  String awayTeamScore;
  String matchId;
  String? round;
  String? stadium;
  String? referee;
  String? audience;
  String? date;
  dynamic homeWinProbabilty;
  dynamic homeOdds;
  String? betName;
  String? betLink;

  Match({
    required this.homeTeamName,
    required this.homeTeamImage,
    required this.homeTeamScore,
    required this.awayTeamName,
    required this.awayTeamImage,
    required this.awayTeamScore,
    required this.matchId,
    this.round,
    this.stadium,
    this.referee,
    this.audience,
    this.date,
    this.homeWinProbabilty,
    this.homeOdds,
    this.betName,
    this.betLink,
  });

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
      stadium: map['estadio'],
      referee: map['arbitro'],
      audience: map['publico'].toString(),
      date: map['data'],
      homeWinProbabilty: map['predicted_odds'],
      homeOdds: map['home_odds'],
      betName: map['home_bookie'],
      betLink: map['home_link'],
    );
  }
}
