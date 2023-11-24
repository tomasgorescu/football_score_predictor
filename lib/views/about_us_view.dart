import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utilites/app_bar_drawer.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 0, end: 85).animate(_controller);

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre nós'),
        toolbarHeight: height,
      ),
      drawer: const AppBarDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Nós predizemos os resultados com ',
                style: TextStyle(fontSize: 24),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  // Display the animated value
                  return Text(
                    '${_animation.value.toInt()}',
                    style: TextStyle(fontSize: 30),
                  );
                },
              ),
              const Text(
                '% accuracy',
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
          const SizedBox(height: 100),
          const Text(
              'Este projeto é fruto do Trabalho de Conclusão de Curso da Engenharia da Computação, da Escola Politécnica da USP'),
          const SizedBox(height: 50),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/devs/GuilhermeBastos.jpeg'),
                    maxRadius: 100.0,
                    minRadius: 25,
                  ),
                  Text('Guilherme Bastos'),
                  SizedBox(height: 20),
                  Text('Engenheiro de computação')
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/devs/GabrielTakayanagi.jpeg'),
                    maxRadius: 100.0,
                    minRadius: 25,
                  ),
                  Text('Gabriel Takayanagi'),
                  SizedBox(height: 20),
                  Text('Engenheiro de computação')
                ],
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/devs/TomasCaldeira.jpeg'),
                    maxRadius: 100.0,
                    minRadius: 25,
                  ),
                  Text('Tomas Caldeira'),
                  SizedBox(height: 20),
                  Text('Engenheiro de computação')
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
