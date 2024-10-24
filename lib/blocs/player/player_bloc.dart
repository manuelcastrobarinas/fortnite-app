import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/models/players/player_stats.dart';

import '../../services/players/player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerServices playerServices;
  PlayerBloc({
    required this.playerServices
  }) : super(const PlayerState()) {
    on<OnGetPlayerAccountEvent>((event, emit) => emit(state.copyWith(player: event.player)));
    on<OnAddPlayerSuggestionEvent>((event, emit) => emit(state.copyWith(playerSuggestions: [event.newPlayerSuggestion, ...state.playerSuggestions])));
    on<OnChangeTeamOptionEvent>((event, emit) => emit(state.copyWith(selectTeamOption: event.changeOptionTeam, selectedStats: event.selectedStats)));
  }

  Future<String> getPlayerAccount({required String userName}) async {
    final getAccountID = await playerServices.getUserID(userName: userName);
    if (getAccountID != 'success') return getAccountID;

    final getPlayerStats = await playerServices.getUserStats();
    if (getPlayerStats != 'success') return getPlayerStats;
    
    add(OnGetPlayerAccountEvent(player: playerServices.playerStatsModel!));
    add(OnChangeTeamOptionEvent(changeOptionTeam: 0, selectedStats: playerServices.playerStatsModel!.globalStats!.solo!));
    return getPlayerStats;
  }  

  void addNewPlayerSuggestion({required PlayerStatsModel newPlayerSuggestion}) => add(OnAddPlayerSuggestionEvent(newPlayerSuggestion: newPlayerSuggestion));
  void setPlayerAccount({required PlayerStatsModel selectedPlayer}) => add(OnGetPlayerAccountEvent(player: selectedPlayer));
  void changeTeamOption({required int newTeamOption, required Map<String, double>? selectedStats}) => add(OnChangeTeamOptionEvent(changeOptionTeam: newTeamOption, selectedStats: selectedStats));
}