import 'package:flutter/material.dart';

import '../constants/routes.dart';

class MatchCard extends StatelessWidget {
  final Image awayTeamImage;
  final Image homeTeamImage;
  final String? homeTeamScore;
  final String? awayTeamScore;
  final String homeTeamName;
  final String awayTeamName;
  final String matchId;
  final String? round;
  final String? stadium;
  final String? referee;
  final String? audience;
  final String? date;
  final dynamic homeWinProbabilty;
  final dynamic homeOdds;
  final String? betName;
  final String? betLink;

  const MatchCard({
    super.key,
    required this.awayTeamImage,
    required this.homeTeamImage,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.matchId,
    this.homeTeamScore,
    this.awayTeamScore,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).pushNamed(
          matchRoute,
          arguments: {
            'matchId': matchId,
            'homeName': homeTeamName,
            'awayName': awayTeamName,
            'awayTeamImage': awayTeamImage,
            'homeTeamImage': homeTeamImage,
            'homeTeamScore': homeTeamScore,
            'awayTeamScore': awayTeamScore,
            'round': round,
            'date': date,
            'stadium': stadium,
            'referee': referee,
            'audience': audience,
            'homeWinProbabilty': homeWinProbabilty,
            'homeOdds': homeOdds,
            'betName': betName,
            'betLink': betLink,
          },
        );
      },
      child: Center(
        child: Card(
          child: SizedBox(
            width: 300,
            height: 100,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 0, top: 4, right: 10, left: 10),
              child: Column(
                children: [
                  Row(
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
                              style: const TextStyle(fontSize: 10),
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
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(round == null ? '' : 'Rodada $round')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
