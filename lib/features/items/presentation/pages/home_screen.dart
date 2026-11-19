import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/error_retry_view.dart';
import 'package:fortnite_app/core/widgets/painters/left_waves_painter_view.dart';
import 'package:fortnite_app/features/items/domain/entities/items.dart';
import 'package:fortnite_app/features/items/presentation/bloc/items_bloc.dart';
import 'package:fortnite_app/features/items/presentation/widgets/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<ItemsModel>? _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final itemsBloc = context.read<ItemsBloc>();
    if (itemsBloc.state.items == null) {
      _future ??= itemsBloc.getItemsGame();
    }
  }

  void _retry() {
    setState(() {
      _future = context.read<ItemsBloc>().getItemsGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasItems = context.watch<ItemsBloc>().state.items != null;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: hasItems
            ? const _HomeInformation()
            : FutureBuilder<ItemsModel>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return ErrorRetryView(
                      message: snapshot.error.toString(),
                      onRetry: _retry,
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('No hay datos'));
                  }
                  return const _HomeInformation();
                },
              ),
      ),
    );
  }
}

class _HomeInformation extends StatelessWidget {
  const _HomeInformation();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        LeftWavesPainterView(colorWave: Colors.white),
        HomeView(),
      ],
    );
  }
}
