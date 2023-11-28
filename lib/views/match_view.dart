import 'package:flutter/material.dart';

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
            Text("Data: ${arguments['date']}"),
            Text("Estádio: ${arguments['stadium']}"),
            Text("Árbitro: ${arguments['referee']}"),
            Text("Público: ${arguments['audience']}"),
          ],
        ),
      ),
    );
  }
}
