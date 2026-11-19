import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/island/domain/entities/island.dart';

abstract class IslandRepository {
  Future<Result<BrMap>> getMap();

  Future<Result<List<GameMode>>> getModes();

  Future<Result<List<NewCosmetic>>> getNewCosmetics();

  Future<Result<CreatorCode>> getCreatorCode(String name);
}
