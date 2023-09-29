import 'package:flutter/material.dart';
import 'package:football_score_predictor/views/seasons_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants/constants.dart';
import 'constants/routes.dart';
import 'utilites/league_card.dart';
import 'views/leagues_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: const String.fromEnvironment('supabaseUrl'),
    anonKey: const String.fromEnvironment('supabaseKey'),
  );
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      matchesRoute: (context) => const LeaguesView(),
      seasonsRoute: (context) => const SeasonView(),
    },
  ));
}

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future =
      supabase.from('competitions').select<List<Map<String, dynamic>>>();
  dynamic leagues;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Predictor'),
        toolbarHeight: height,
      ),
      drawer: Drawer(
        child: ListView(
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final leagues = snapshot.data!;
            return ListView.builder(
              itemCount: leagues.length,
              itemBuilder: ((context, index) {
                final league = leagues[index];
                return LeagueCard(
                  leagueId: league['competition_id'].toString(),
                  leagueName: league['competition_name'].toString(),
                  child: Image.network(
                    league['competition_image'],
                  ),
                );
              }),
            );
          }),
    );
  }
}
