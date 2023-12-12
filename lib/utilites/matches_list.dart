import 'package:flutter/material.dart';

import '../repositories/match_repository.dart';
import 'match_card.dart';

class MatchesList extends StatefulWidget {
  const MatchesList({super.key, this.seasonId});
  final int? seasonId;

  @override
  State<MatchesList> createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  int? _currentSeasonId;
  late MatchRepository matchRepo;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    _currentSeasonId = widget.seasonId;
    matchRepo = MatchRepository();
    loadMatches();
  }

  infiniteScrolling() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !loading.value) {
      loadMatches();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  loadMatches() async {
    loading.value = true;
    await matchRepo.getMatches(_currentSeasonId ?? 2023);
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: matchRepo,
        builder: (context, snapshot) {
          return Stack(
            children: [
              ListView.separated(
                  controller: _scrollController,
                  itemBuilder: ((context, index) {
                    final match = matchRepo.matches[index];
                    return MatchCard(
                      matchId: match.matchId,
                      awayTeamImage: Image.asset(
                        match.awayTeamImage,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/clubs/placeholder.jpeg",
                          );
                        },
                      ),
                      awayTeamScore: match.awayTeamScore,
                      awayTeamName: match.awayTeamName,
                      homeTeamImage: Image.asset(
                        match.homeTeamImage,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/clubs/placeholder.jpeg",
                          );
                        },
                      ),
                      homeTeamScore: match.homeTeamScore,
                      homeTeamName: match.homeTeamName,
                      round: match.round,
                      stadium: match.stadium,
                      referee: match.referee,
                      audience: match.audience,
                      date: match.date,
                      homeWinProbabilty: match.homeWinProbabilty,
                      homeOdds: match.homeOdds,
                      betName: match.betName,
                      betLink: match.betLink,
                    );
                  }),
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: matchRepo.matches.length),
              loadingIndicatorWidget(),
            ],
          );
        });
  }

  loadingIndicatorWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 24,
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircleAvatar(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
                )
              : Container();
        });
  }
}
