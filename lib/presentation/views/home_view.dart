import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/components/components.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/delegates/search_item.dart';
import 'package:fortnite_app/models/items/items.dart';
import 'package:fortnite_app/utils/background_items_color.dart';

import '../../blocs/items/items_bloc.dart';

class HomeView extends StatelessWidget {
  
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(color: kPrimaryTextColor, fontSize: 52, overflow: TextOverflow.ellipsis);
    return  SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child : BlocBuilder<ItemsBloc, ItemsState>(
          builder: (BuildContext context, ItemsState state) {
            MainStats? waponStadistics = state.selectedWeapon!.mainStats;
            List<StadisticSections> listStadistics = [
              StadisticSections(title: "Daño", value: waponStadistics?.dmgPb.toString() ?? 'no registra'),
              StadisticSections(title: "Tasa de disparo", value: waponStadistics?.firingRate.toString() ?? 'no registra'),
              StadisticSections(title: "Tamaño del clip", value: waponStadistics?.clipSize.toString() ?? 'no registra'),
              StadisticSections(title: "Tiempo|recarga",  value: waponStadistics?.reloadTime.toString() ?? 'no registra'),
              StadisticSections(title: "Balas|cartucho",  value: waponStadistics?.bulletsPerCartridge.toString() ?? 'no registra'),
              StadisticSections(title: "Daño critico",    value: waponStadistics?.damageZoneCritical.toString()?? 'no registra'),
            ];
            return Column(
              children: [
                const SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      flex  : 7,
                      child : Text("Aprende sobre los items", style: titleStyle, maxLines: 2),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => showSearch(delegate: SearchItemDelegate(), context: context),
                        icon: const Icon(Icons.search, size: 38),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const _SubtitleSection(),
                _ShowItem(urlImage: state.selectedWeapon?.images?.icon),
                _ItemName(
                  weaponName: state.selectedWeapon?.name!,
                  rarity: state.selectedWeapon?.rarity,
                ),
                const SizedBox(height: 20.0),
                _SelectItemList(itemsList: state.items!.weapons!),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: StadisticsWaponsComponent(
                    listStadistics: listStadistics
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SelectItemList extends StatelessWidget {
  final List<Weapon> itemsList;
  
  const _SelectItemList({
    required this.itemsList
  });

  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = BlocProvider.of<ItemsBloc>(context);
    return SizedBox(
      height: 95,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
          itemCount:  itemsList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int i) {
            return  GestureDetector(
              onTap: () => itemsBloc.setNewSelectedWapon(newSelectedWeapon: itemsList[i]),
              child: Stack(
                children: [
                  Container(
                    width : 70, // Ancho de cada ítem
                    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: setBackgroundItemColor(itemsList[i].rarity!),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading/load.gif'),
                        image: (itemsList[i].images!.icon != null) 
                          ? NetworkImage(itemsList[i].images!.icon!) 
                          : const AssetImage('assets/loading/vbuck.png')
                      ),
                    ),
                  ),
                ],
              )
            );
          }
        ),
      ),
    );
  }
}

class _ItemName extends StatelessWidget {
  final String? weaponName;
  final Rarity? rarity;

  const _ItemName({
    required this.weaponName,
    required this.rarity
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        SizedBox(
          child:Text(
            (weaponName == null || rarity == null) ? 'No registra' : '$weaponName',
            style: const TextStyle(color: kPrimaryTextColor, fontSize: 18, overflow: TextOverflow.ellipsis)
          )
        ),
        SizedBox(
          child:Text(
            (rarity == null) ? 'No registra' : '(${setRarityItemName(rarity!)})',
            style: TextStyle(color: setBackgroundItemColor(rarity!), fontSize: 18, overflow: TextOverflow.ellipsis)
          )
        ),
      ],
    );
  }
}

class _ShowItem extends StatelessWidget {
  final String? urlImage;

  const _ShowItem({
    required this.urlImage,
  });

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
            Center(
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading/load.gif'),
                image: urlImage != null ? NetworkImage(urlImage!) : const AssetImage('assets/loading/vbuck.png')
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