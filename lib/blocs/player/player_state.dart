part of 'player_bloc.dart';

class PlayerState extends Equatable {
  final PlayerStatsModel? player; //JUGADOR SELECCIONADO ACTUALMENTE
  final List<PlayerStatsModel> playerSuggestions; //LISTA DE SUGERENCIAS DE JUGADORES BUSCADOS
  final int selectTeamOption;
  final Map<String, double>? selectedStats;

  const PlayerState({
    this.player,
    this.playerSuggestions = const [],
    this.selectTeamOption = 0,
    this.selectedStats
  });
  
  PlayerState copyWith({
    PlayerStatsModel? player,
    List<PlayerStatsModel>? playerSuggestions,
    Map<String, double>? selectedStats,
    int? selectTeamOption,
  }) => PlayerState(
    player: player ?? this.player,
    playerSuggestions : playerSuggestions ?? this.playerSuggestions,
    selectTeamOption  : selectTeamOption ?? this.selectTeamOption,
    selectedStats     : selectedStats ?? this.selectedStats  
  );

  @override
  List<Object?> get props => [player, playerSuggestions, selectTeamOption, selectedStats];
}