import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/router/app_router.dart';
import 'package:fortnite_app/core/errors/failures.dart';
import 'package:fortnite_app/core/utils/result.dart';
import 'package:fortnite_app/features/items/domain/entities/items.dart';
import 'package:fortnite_app/features/items/domain/repositories/items_repository.dart';
import 'package:fortnite_app/features/items/domain/usecases/get_items_usecase.dart';
import 'package:fortnite_app/features/items/presentation/bloc/items_bloc.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';
import 'package:fortnite_app/features/news/domain/repositories/news_repository.dart';
import 'package:fortnite_app/features/news/domain/usecases/get_news_usecase.dart';
import 'package:fortnite_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:fortnite_app/features/players/domain/entities/player_profile.dart';
import 'package:fortnite_app/features/players/domain/repositories/player_repository.dart';
import 'package:fortnite_app/features/players/domain/usecases/get_player_by_username_usecase.dart';
import 'package:fortnite_app/features/players/presentation/bloc/player_bloc.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/domain/repositories/shop_repository.dart';
import 'package:fortnite_app/features/shop/domain/usecases/get_shop_usecase.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';

class _EmptyItemsRepository implements ItemsRepository {
  @override
  Future<Result<ItemsModel>> getItems() async =>
      const Err(NetworkFailure('sin red'));
}

class _EmptyNewsRepository implements NewsRepository {
  @override
  Future<Result<NewsModel>> getNews() async =>
      const Err(NetworkFailure('sin red'));
}

class _EmptyPlayerRepository implements PlayerRepository {
  @override
  Future<Result<PlayerProfile>> getByUsername(String username) async =>
      const Err(NetworkFailure('sin red'));
}

class _EmptyShopRepository implements ShopRepository {
  @override
  Future<Result<ShopLimited>> getShop() async =>
      const Err(NetworkFailure('sin red'));
}

/// MaterialApp de prueba con blocs que no tocan la red.
Widget testApp({required Widget home}) {
  return MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ItemsBloc(getItems: GetItemsUseCase(_EmptyItemsRepository())),
      ),
      BlocProvider(
        create: (_) => NewsBloc(getNews: GetNewsUseCase(_EmptyNewsRepository())),
      ),
      BlocProvider(
        create: (_) => PlayerBloc(
          getPlayerByUsername: GetPlayerByUsernameUseCase(_EmptyPlayerRepository()),
        ),
      ),
      BlocProvider(
        create: (_) => ShopBloc(getShop: GetShopUseCase(_EmptyShopRepository())),
      ),
    ],
    child: MaterialApp(home: home, routes: routes),
  );
}
