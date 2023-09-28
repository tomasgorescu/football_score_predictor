import 'package:flutter/material.dart';
import '../constants/constants.dart';

class LeaguesView extends StatefulWidget {
  const LeaguesView({super.key});

  @override
  State<LeaguesView> createState() => _LeaguesViewState();
}

class _LeaguesViewState extends State<LeaguesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Score Predictor'),
          toolbarHeight: height,
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: height + MediaQuery.of(context).viewPadding.top,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('Drawer Header'),
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: const Column(
          children: [
            MatchCard(
              awayTeamImage:
                  Image(image: AssetImage('assets/images/clubs/ammg.png')),
              homeTeamImage: Image(
                  image: AssetImage('assets/images/clubs/corinthians.png')),
              homeTeamScore: '1',
              awayTeamScore: '2',
            ),
            MatchCard(
              awayTeamImage:
                  Image(image: AssetImage('assets/images/clubs/atlpr.png')),
              homeTeamImage:
                  Image(image: AssetImage('assets/images/clubs/coritiba.png')),
            ),
            MatchCard(
              awayTeamImage:
                  Image(image: AssetImage('assets/images/clubs/palmeiras.png')),
              homeTeamImage:
                  Image(image: AssetImage('assets/images/clubs/santos.png')),
            )
          ],
        ));
  }
}

class MatchCard extends StatelessWidget {
  final Image awayTeamImage;
  final Image homeTeamImage;
  final String? homeTeamScore;
  final String? awayTeamScore;

  const MatchCard({
    super.key,
    required this.awayTeamImage,
    required this.homeTeamImage,
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
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                homeTeamImage,
                Text(
                  homeTeamScore ?? '',
                  style: const TextStyle(fontSize: 35),
                ),
                const Text('X'),
                Text(
                  awayTeamScore ?? '',
                  style: const TextStyle(fontSize: 35),
                ),
                awayTeamImage,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
