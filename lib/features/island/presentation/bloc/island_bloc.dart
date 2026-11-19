import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/features/island/domain/entities/island.dart';
import 'package:fortnite_app/features/island/domain/usecases/island_usecases.dart';

part 'island_state.dart';

/// Carga mapa, modos y cosméticos nuevos. Cada sección pide su futuro
/// cuando el usuario la abre, para no bajar los modos (el JSON pesa más)
/// si solo quiere ver el mapa.
class IslandBloc extends Bloc<IslandEvent, IslandState> {
  IslandBloc({
    required GetBrMapUseCase getMap,
    required GetGameModesUseCase getModes,
    required GetNewCosmeticsUseCase getNewCosmetics,
    required GetCreatorCodeUseCase getCreatorCode,
  })  : _getMap = getMap,
        _getModes = getModes,
        _getNewCosmetics = getNewCosmetics,
        _getCreatorCode = getCreatorCode,
        super(const IslandState());

  final GetBrMapUseCase _getMap;
  final GetGameModesUseCase _getModes;
  final GetNewCosmeticsUseCase _getNewCosmetics;
  final GetCreatorCodeUseCase _getCreatorCode;

  Future<BrMap> getMap() async {
    final result = await _getMap();
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (map) => map,
    );
  }

  Future<List<GameMode>> getModes() async {
    final result = await _getModes();
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (modes) => modes,
    );
  }

  Future<List<NewCosmetic>> getNewCosmetics() async {
    final result = await _getNewCosmetics();
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (cosmetics) => cosmetics,
    );
  }

  Future<CreatorCode> lookupCreatorCode(String name) async {
    final result = await _getCreatorCode(name);
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (code) => code,
    );
  }
}

abstract class IslandEvent extends Equatable {
  const IslandEvent();

  @override
  List<Object?> get props => [];
}
