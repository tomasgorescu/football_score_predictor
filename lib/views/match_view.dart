import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';
import '../utilites/app_bar_drawer.dart';

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
    print(arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text('${arguments['homeName']} X ${arguments['awayName']}'),
        toolbarHeight: height,
      ),
      drawer: const AppBarDrawer(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: arguments['homeTeamImage'],
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
                  arguments['homeTeamScore'] ?? '',
                  style: const TextStyle(fontSize: 35),
                ),
                const Text('X'),
                Text(
                  arguments['awayTeamScore'] ?? '',
                  style: const TextStyle(fontSize: 35),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: arguments['awayTeamImage'],
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
            if (arguments['homeWinProbabilty'] != null)
              HomeWinProbabiltyIndicator(
                homeWinProbabilty: arguments['homeWinProbabilty'],
              ),
            const SizedBox(height: 50),
            Text("Data: ${arguments['date']}"),
            Text("Estádio: ${arguments['stadium']}"),
            Text("Árbitro: ${arguments['referee']}"),
            Text("Público: ${arguments['audience']}"),
            const SizedBox(height: 30),
            if (arguments['betName'] != null &&
                arguments['betLink'] != null &&
                arguments['homeOdds'] != null)
              BestBetLink(
                betName: arguments['betName'],
                urlLink: arguments['betLink'],
                odds: arguments['homeOdds'].toString(),
              )
          ],
        ),
      ),
    );
  }
}

class HomeWinProbabiltyIndicator extends StatefulWidget {
  final dynamic homeWinProbabilty;
  const HomeWinProbabiltyIndicator({super.key, this.homeWinProbabilty});

  @override
  State<HomeWinProbabiltyIndicator> createState() =>
      _HomeWinProbabiltyIndicatorState();
}

class _HomeWinProbabiltyIndicatorState extends State<HomeWinProbabiltyIndicator>
    with TickerProviderStateMixin {
  late AnimationController _profitController;
  late Animation<double> _profitAnimation;
  dynamic _homeWinProbabilty;

  @override
  void initState() {
    super.initState();

    _homeWinProbabilty = widget.homeWinProbabilty;
    _profitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _profitAnimation = Tween<double>(begin: 0, end: (_homeWinProbabilty * 100))
        .animate(_profitController);

    // Start the animation
    _profitController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return (_homeWinProbabilty == null)
        ? const SizedBox.shrink()
        : AnimatedBuilder(
            animation: _profitAnimation,
            builder: (context, child) {
              // Display the animated value
              return Column(
                children: [
                  if (_homeWinProbabilty != null)
                    Text(
                      'Score de vitória do time de casa: ${_profitAnimation.value.toDouble().round()}',
                      style: const TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 10),
                  if (_homeWinProbabilty != null)
                    LinearProgressIndicator(
                      value: _homeWinProbabilty.toDouble(),
                    ),
                ],
              );
            },
          );
  }
}

class BestBetLink extends StatelessWidget {
  final String? urlLink;
  final String? betName;
  final String? odds;

  const BestBetLink({
    super.key,
    this.urlLink,
    this.betName,
    this.odds,
  });

  @override
  Widget build(BuildContext context) {
    return (urlLink == null || betName == null || odds == null)
        ? const SizedBox.shrink()
        : Column(
            children: [
              Text('As melhores odds para essa aposta são de $odds'),
              GestureDetector(
                onTap: _launchBetUrl,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Clique para apostar com essas odds na '),
                    Text(
                      '$betName',
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ],
                ),
              )
            ],
          );
  }

  _launchBetUrl() async {
    final Uri url = Uri.parse(urlLink ?? '');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
