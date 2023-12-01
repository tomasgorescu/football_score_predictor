import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utilites/app_bar_drawer.dart';
import "package:simple_icons/simple_icons.dart";
import 'package:url_launcher/url_launcher.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView>
    with TickerProviderStateMixin {
  late AnimationController _accuracyController;
  late Animation<double> _accuracyAnimation;

  late AnimationController _profitController;
  late Animation<double> _profitAnimation;

  @override
  void initState() {
    super.initState();

    // Set up the animation controller
    _accuracyController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _profitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _accuracyAnimation =
        Tween<double>(begin: 0, end: 85).animate(_accuracyController);
    _profitAnimation =
        Tween<double>(begin: 0, end: 10).animate(_profitController);

    // Start the animation
    _accuracyController.forward();
    _profitController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre o Projeto'),
        toolbarHeight: height,
      ),
      drawer: const AppBarDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'Futebol não é brincaidera... muito menos quando tem dinheiro envolvido ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            // AnimatedBuilder(
            //   animation: _accuracyAnimation,
            //   builder: (context, child) {
            //     // Display the animated value
            //     return Text(
            //       'Nós predizemos os resultados com  ${_accuracyAnimation.value.toInt()}% de precisão',
            //       style: const TextStyle(fontSize: 30),
            //     );
            //   },
            // ),
            const Text(
              'Este projeto começou com o objetivo de criar uma forma de prever resultado de partidas com base em Aprendizado de Máquina. Como você pode imaginar, o futebol tem milhões de variáveis muito difíceis de quantificar, como as de carater psicológico. Que modelo consegue prever quando o craque teve uma discussão na noite anterior?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Aí que está a chave: o modelo não precisa ser perfeito, só precisa ser melhor que o das casas de aposta.',
              textAlign: TextAlign.center,
            ),
            const Text(
              'Então, além da construção do nosso modelo, começamos a treina-lo, comparando com as odds e buscando as melhores apostas.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Nós conseguimos lucrar',
                  style: TextStyle(fontSize: 20),
                ),
                AnimatedBuilder(
                  animation: _profitAnimation,
                  builder: (context, child) {
                    // Display the animated value
                    return Text(
                      ' ${_profitAnimation.value.toInt()}% ',
                      style: const TextStyle(fontSize: 25),
                    );
                  },
                ),
                const Text(
                  'na média das apostas',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Aqui mesmo você vai encontrar as nossas recomendações de melhores apostas para cada rodada, na aba "Melhores Apostas".',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const Text(
                'Este projeto é fruto do Trabalho de Conclusão de Curso da Engenharia da Computação, da Escola Politécnica da USP'),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DevIcon(
                        imagePath: 'assets/images/devs/GuilhermeBastos.jpeg',
                        name: 'Guilherme Bastos',
                        role: 'Engenheiro de computação',
                      ),
                      DevIcon(
                        imagePath: 'assets/images/devs/GabrielTakayanagi.jpeg',
                        name: 'Gabriel Takayanagi',
                        role: 'Engenheiro de computação',
                      ),
                      DevIcon(
                        imagePath: 'assets/images/devs/TomasCaldeira.jpeg',
                        name: 'Tomas Caldeira',
                        role: 'Engenheiro de computação',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 50,
                      onPressed: _launchGitUrl,
                      icon: const Icon(SimpleIcons.github),
                    ),
                    const Text('GitHub')
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      iconSize: 50,
                      onPressed: _launchPaperUrl,
                      icon: const Icon(
                        Icons.article,
                      ),
                    ),
                    const Text('Paper')
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _accuracyController.dispose();
    _profitController.dispose();
    super.dispose();
  }

  _launchGitUrl() async {
    final Uri url =
        Uri.parse('https://github.com/tomasgorescu/football_score_predictor');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  _launchPaperUrl() async {
    final Uri url = Uri.parse(
        'https://lfjtuqqdoerrfsivceia.supabase.co/storage/v1/object/public/documents/TCC_PCS_EPUSP.pdf');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

class DevIcon extends StatelessWidget {
  final String name;
  final String imagePath;
  final String role;

  const DevIcon({
    super.key,
    required this.name,
    required this.imagePath,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            maxRadius: 50.0,
            minRadius: 25,
          ),
          Text(name),
          const SizedBox(height: 20),
          Text(role)
        ],
      ),
    );
  }
}
