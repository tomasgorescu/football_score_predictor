import 'package:flutter/material.dart';

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
          ),
        ),
      ),
    );
  }
}
