import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fortnite_app/components/components.dart';
import 'package:fortnite_app/contants.dart';

import '../../blocs/items/items_bloc.dart';

class HomeView extends StatelessWidget {

  final ItemsState state;
  
  const HomeView({
    super.key,
    required this.state
  });

 

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(color: kPrimaryTextColor, fontSize: 66, overflow: TextOverflow.ellipsis);
    final List<StadisticSections> listStadistics = [
      const StadisticSections(title: "Daño", value: "36"),
      const StadisticSections(title: "Tasa de disparo", value: "5.5"),
      const StadisticSections(title: "Tamaño del clip", value: "30"),
      const StadisticSections(title: "Tiempo|recarga", value: "2.25"),
      const StadisticSections(title: "Balas|cartucho", value: "1"),
      const StadisticSections(title: "Daño critico", value: "1.5"),
    ];
    return  SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child : Column(
          children: [
            const SizedBox(height: 20.0),
            const Text("Aprende sobre los items", style: titleStyle, maxLines: 2),
            const SizedBox(height: 20.0),
            const _SubtitleSection(),
            const _ShowItem(),
            const _ItemName(),
            const SizedBox(height: 20.0),
            const _SelectItemList(),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: StadisticsWaponsComponent(
                listStadistics: listStadistics
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class _SelectItemList extends StatelessWidget {
  const _SelectItemList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int i) {
            return  Stack(
              children: [
                Container(
                  width : 70, // Ancho de cada ítem
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: FadeInImage(
                      placeholder: AssetImage('assets/loading/load.gif'),
                      image: NetworkImage('https://media.fortniteapi.io/images/WID_Assault_AutoDrum_Athena_R_Ore_T03.png')
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}

class _ItemName extends StatelessWidget {
  const _ItemName();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: SizedBox()),
        SizedBox(
          child:Text("Subfusil de tambor de legado", style:  TextStyle(color: kPrimaryTextColor, fontSize: 18, overflow: TextOverflow.ellipsis),)
        ),
      ],
    );
  }
}

class _ShowItem extends StatelessWidget {
  const _ShowItem();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipOval(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: const CircleAvatar(
                    radius: double.infinity,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            const Center(
              child: FadeInImage(
                placeholder: AssetImage('assets/loading/load.gif'),
                image: NetworkImage('https://media.fortniteapi.io/images/WID_Assault_AutoDrum_Athena_R_Ore_T03.png')
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubtitleSection extends StatelessWidget {

  const _SubtitleSection();
  @override
  Widget build(BuildContext context) {
    const TextStyle subtitleStyle = TextStyle(color: kPrimaryTextColor, fontSize: 22, overflow: TextOverflow.ellipsis);
    return const SizedBox(
      width: double.infinity,
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment : MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Icon(Icons.star, color: Colors.amber)
          ),
          Expanded(
            flex: 9,
            child: Text("Selecciona un item", style: subtitleStyle, maxLines: 1)
          ),  
        ],
      ),
    );
  }
}