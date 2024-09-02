part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class OnGetPlayerAccountEvent extends PlayerEvent {
  final PlayerStatsModel player;

  const OnGetPlayerAccountEvent({
    required this.player
  });
}

class OnAddPlayerSuggestionEvent extends PlayerEvent { //evento para añadir un jugador que encontramos a la lista de sugerencias del delegate
  final PlayerStatsModel newPlayerSuggestion;

  const OnAddPlayerSuggestionEvent({
    required this.newPlayerSuggestion
  });
}

class OnChangeTeamOptionEvent extends PlayerEvent {
  final int changeOptionTeam;
  final Map<String, double>? selectedStats;

  const OnChangeTeamOptionEvent({
    required this.changeOptionTeam,
    required this.selectedStats
  });
}