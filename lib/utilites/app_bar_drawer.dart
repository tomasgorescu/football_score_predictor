import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/routes.dart';

class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: height + MediaQuery.of(context).viewPadding.top,
            child: const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
          ),
          ListTile(
            title: const Text('Outras temporadas'),
            onTap: () {
              Navigator.of(context).pushNamed(seasonsRoute);
            },
          ),
          ListTile(
            title: const Text('Rodada Mais Recente'),
            onTap: () {
              Navigator.of(context).pushNamed(paginatedMatchesRoute,
                  arguments: {'leagueName': 'Brasileirão'});
            },
          ),
          ListTile(
            title: const Text('Sobre o Projeto'),
            onTap: () {
              Navigator.of(context).pushNamed(aboutUsRoute);
            },
          ),
          // SeasonView() was left out while we gather more data and modeling towards other leagues results
        ],
      ),
    );
  }
}
