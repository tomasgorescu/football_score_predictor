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
            title: const Text('Todas as Ligas'),
            onTap: () {
              Navigator.of(context).pushNamed(leaguesRoute);
            },
          ),
          ListTile(
            title: const Text('Rodada Mais Recente- Brasileirão'),
            onTap: () {
              Navigator.of(context).pushNamed(brMatchesRoute);
            },
          ),
          ListTile(
            title: const Text('Sobre o Projeto'),
            onTap: () {
              Navigator.of(context).pushNamed(aboutUsRoute);
            },
          ),
        ],
      ),
    );
  }
}
