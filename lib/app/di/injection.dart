import 'package:fortnite_app/core/config/env_config.dart';
import 'package:fortnite_app/core/di/service_locator.dart';
import 'package:fortnite_app/core/network/dio_http_client.dart';
import 'package:fortnite_app/features/island/data/datasources/island_remote_datasource.dart';
import 'package:fortnite_app/features/island/data/repositories/island_repository_impl.dart';
import 'package:fortnite_app/features/island/domain/repositories/island_repository.dart';
import 'package:fortnite_app/features/island/domain/usecases/island_usecases.dart';
import 'package:fortnite_app/features/island/presentation/bloc/island_bloc.dart';
import 'package:fortnite_app/features/items/data/datasources/items_remote_datasource.dart';
import 'package:fortnite_app/features/items/data/repositories/items_repository_impl.dart';
import 'package:fortnite_app/features/items/domain/repositories/items_repository.dart';
import 'package:fortnite_app/features/items/domain/usecases/get_items_usecase.dart';
import 'package:fortnite_app/features/items/presentation/bloc/items_bloc.dart';
import 'package:fortnite_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:fortnite_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:fortnite_app/features/news/domain/repositories/news_repository.dart';
import 'package:fortnite_app/features/news/domain/usecases/get_news_usecase.dart';
import 'package:fortnite_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:fortnite_app/features/players/data/datasources/player_remote_datasource.dart';
import 'package:fortnite_app/features/players/data/repositories/player_repository_impl.dart';
import 'package:fortnite_app/features/players/domain/repositories/player_repository.dart';
import 'package:fortnite_app/features/players/domain/usecases/get_player_by_username_usecase.dart';
import 'package:fortnite_app/features/players/presentation/bloc/player_bloc.dart';
import 'package:fortnite_app/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:fortnite_app/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:fortnite_app/features/shop/domain/repositories/shop_repository.dart';
import 'package:fortnite_app/features/shop/domain/usecases/get_shop_usecase.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';

/// Composition root: único lugar donde se decide qué implementación
/// respalda cada contrato.
void setupDependencies() {
  initCoreInjections();
  initNewsInjections();
  initItemsInjections();
  initPlayerInjections();
  initShopInjections();
  initIslandInjections();
}

void initCoreInjections() {
  sl.registerLazySingleton<PublicApiClient>(
    () => PublicApiClient(
      baseUrl: EnvConfig.publicApiUrl,
      defaultQueryParameters: const {'language': 'es'},
    ),
  );
  sl.registerLazySingleton<CatalogApiClient>(
    () => CatalogApiClient(baseUrl: EnvConfig.weaponsApiUrl),
  );
}

void initNewsInjections() {
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(sl.get<PublicApiClient>()),
  );
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(sl.get<NewsRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetNewsUseCase>(
    () => GetNewsUseCase(sl.get<NewsRepository>()),
  );
  sl.registerLazySingleton<NewsBloc>(
    () => NewsBloc(getNews: sl.get<GetNewsUseCase>()),
  );
}

void initItemsInjections() {
  sl.registerLazySingleton<ItemsRemoteDataSource>(
    () => ItemsRemoteDataSourceImpl(sl.get<CatalogApiClient>()),
  );
  sl.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(sl.get<ItemsRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetItemsUseCase>(
    () => GetItemsUseCase(sl.get<ItemsRepository>()),
  );
  sl.registerLazySingleton<ItemsBloc>(
    () => ItemsBloc(getItems: sl.get<GetItemsUseCase>()),
  );
}

void initPlayerInjections() {
  sl.registerLazySingleton<PlayerRemoteDataSource>(
    () => PlayerRemoteDataSourceImpl(
      sl.get<CatalogApiClient>(),
      sl.get<PublicApiClient>(),
      statsApiKey: EnvConfig.publicApiKey,
    ),
  );
  sl.registerLazySingleton<PlayerRepository>(
    () => PlayerRepositoryImpl(sl.get<PlayerRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetPlayerByUsernameUseCase>(
    () => GetPlayerByUsernameUseCase(sl.get<PlayerRepository>()),
  );
  sl.registerLazySingleton<PlayerBloc>(
    () => PlayerBloc(getPlayerByUsername: sl.get<GetPlayerByUsernameUseCase>()),
  );
}

void initShopInjections() {
  sl.registerLazySingleton<ShopRemoteDataSource>(
    () => ShopRemoteDataSourceImpl(sl.get<PublicApiClient>()),
  );
  sl.registerLazySingleton<ShopRepository>(
    () => ShopRepositoryImpl(sl.get<ShopRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetShopUseCase>(
    () => GetShopUseCase(sl.get<ShopRepository>()),
  );
  sl.registerLazySingleton<ShopBloc>(
    () => ShopBloc(getShop: sl.get<GetShopUseCase>()),
  );
}

void initIslandInjections() {
  sl.registerLazySingleton<IslandRemoteDataSource>(
    () => IslandRemoteDataSourceImpl(sl.get<PublicApiClient>()),
  );
  sl.registerLazySingleton<IslandRepository>(
    () => IslandRepositoryImpl(sl.get<IslandRemoteDataSource>()),
  );
  sl.registerLazySingleton<GetBrMapUseCase>(
    () => GetBrMapUseCase(sl.get<IslandRepository>()),
  );
  sl.registerLazySingleton<GetGameModesUseCase>(
    () => GetGameModesUseCase(sl.get<IslandRepository>()),
  );
  sl.registerLazySingleton<GetNewCosmeticsUseCase>(
    () => GetNewCosmeticsUseCase(sl.get<IslandRepository>()),
  );
  sl.registerLazySingleton<GetCreatorCodeUseCase>(
    () => GetCreatorCodeUseCase(sl.get<IslandRepository>()),
  );
  sl.registerLazySingleton<IslandBloc>(
    () => IslandBloc(
      getMap: sl.get<GetBrMapUseCase>(),
      getModes: sl.get<GetGameModesUseCase>(),
      getNewCosmetics: sl.get<GetNewCosmeticsUseCase>(),
      getCreatorCode: sl.get<GetCreatorCodeUseCase>(),
    ),
  );
}
