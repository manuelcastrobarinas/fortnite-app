import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/router/app_router.dart';
import 'package:fortnite_app/app/theme/app_theme.dart';
import 'package:fortnite_app/core/di/service_locator.dart';
import 'package:fortnite_app/features/items/presentation/bloc/items_bloc.dart';
import 'package:fortnite_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:fortnite_app/features/players/presentation/bloc/player_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';

/// Widget raíz de la aplicación.
///
/// Es el único lugar donde se configura MaterialApp: tema, rutas y los
/// blocs de aplicación. `main.dart` solo hace bootstrap y delega aquí.
class FortniteApp extends StatelessWidget {
  const FortniteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemsBloc>.value(value: sl.get<ItemsBloc>()),
        BlocProvider<NewsBloc>.value(value: sl.get<NewsBloc>()),
        BlocProvider<PlayerBloc>.value(value: sl.get<PlayerBloc>()),
        BlocProvider<ShopBloc>.value(value: sl.get<ShopBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fortnite Flutter App',
        theme: AppTheme.light,
        routes: routes,
        initialRoute: AppRoutes.loading,
      ),
    );
  }
}
