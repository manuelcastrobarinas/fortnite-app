import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/blocs/items/items_bloc.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/presentation/views/home_view.dart';
import 'package:fortnite_app/presentation/views/painters/left_waves_painter_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc  = BlocProvider.of<ItemsBloc>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future  : itemsBloc.getItemsGame(), 
          builder : (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
            if (snapshot.connectionState == ConnectionState.none)    return const Center(child: Text("No hay conexión"));
            if (snapshot.hasError || snapshot.error == true)         return Center(child: Text(snapshot.error.toString()));
            if (snapshot.data != 'success') return Center(child: Text(snapshot.data.toString()));
            return BlocBuilder<ItemsBloc, ItemsState>(
              builder: (context, state) => _HomeInformation(state: state),
            );
          }
        )
      ),
    );
  }
}

class _HomeInformation extends StatelessWidget {
  final ItemsState state;

  const _HomeInformation({
    required this.state
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LeftWavesPainterView(colorWave: Colors.white),
        HomeView(state: state,),
      ],
    );
  }
}