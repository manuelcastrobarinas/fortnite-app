import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/island/domain/entities/island.dart';
import 'package:fortnite_app/features/island/domain/repositories/island_repository.dart';

class GetBrMapUseCase {
  const GetBrMapUseCase(this._repository);

  final IslandRepository _repository;

  Future<Result<BrMap>> call() => _repository.getMap();
}

class GetGameModesUseCase {
  const GetGameModesUseCase(this._repository);

  final IslandRepository _repository;

  Future<Result<List<GameMode>>> call() => _repository.getModes();
}

class GetNewCosmeticsUseCase {
  const GetNewCosmeticsUseCase(this._repository);

  final IslandRepository _repository;

  Future<Result<List<NewCosmetic>>> call() => _repository.getNewCosmetics();
}

class GetCreatorCodeUseCase {
  const GetCreatorCodeUseCase(this._repository);

  final IslandRepository _repository;

  Future<Result<CreatorCode>> call(String name) =>
      _repository.getCreatorCode(name);
}
