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
              child: Text('Drawer Header'),
            ),
          ),
          ListTile(
            title: const Text('Ligas'),
            onTap: () {
              Navigator.of(context).pushNamed(leaguesRoute);
            },
          ),
          ListTile(
            title: const Text('Rodada Mais Recente'),
            onTap: () {
              Navigator.of(context).pushNamed(brMatchesRoute);
            },
          ),
        ],
      ),
    );
  }
}
