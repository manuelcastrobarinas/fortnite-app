import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/features/players/domain/entities/player_account.dart';
import 'package:fortnite_app/features/players/domain/entities/player_stats.dart';
import 'package:fortnite_app/features/players/domain/usecases/get_player_by_username_usecase.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({required GetPlayerByUsernameUseCase getPlayerByUsername})
      : _getPlayerByUsername = getPlayerByUsername,
        super(const PlayerState()) {
    on<OnGetPlayerAccountEvent>(
      (event, emit) => emit(state.copyWith(player: event.player)),
    );
    on<OnAddPlayerSuggestionEvent>(
      (event, emit) => emit(
        state.copyWith(
          playerSuggestions: [event.newPlayerSuggestion, ...state.playerSuggestions],
        ),
      ),
    );
    on<OnChangeTeamOptionEvent>(
      (event, emit) => emit(
        state.copyWith(
          selectTeamOption: event.changeOptionTeam,
          selectedStats: event.selectedStats,
        ),
      ),
    );
  }

  final GetPlayerByUsernameUseCase _getPlayerByUsername;

  Future<PlayerIDmodel> getPlayerAccount({required String userName}) async {
    final result = await _getPlayerByUsername(userName);
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (profile) {
        add(OnGetPlayerAccountEvent(player: profile.stats));
        add(
          OnChangeTeamOptionEvent(
            changeOptionTeam: 0,
            selectedStats: profile.stats.globalStats?.solo,
          ),
        );
        return profile.account;
      },
    );
  }

  void addNewPlayerSuggestion({required PlayerStatsModel newPlayerSuggestion}) {
    add(OnAddPlayerSuggestionEvent(newPlayerSuggestion: newPlayerSuggestion));
  }

  void setPlayerAccount({required PlayerStatsModel selectedPlayer}) {
    add(OnGetPlayerAccountEvent(player: selectedPlayer));
  }

  void changeTeamOption({
    required int newTeamOption,
    required Map<String, double>? selectedStats,
  }) {
    add(
      OnChangeTeamOptionEvent(
        changeOptionTeam: newTeamOption,
        selectedStats: selectedStats,
      ),
    );
  }
}
