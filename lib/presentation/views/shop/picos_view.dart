import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/utils/shop/replace_color_shops.dart';

import '../../../blocs/shop/shop_bloc.dart';
import '../../../models/shop/shop_limited.dart';

class PicosView extends StatelessWidget {
  const PicosView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    return SingleChildScrollView(
      controller: controller,
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return (state.picosShop.isEmpty) 
          ? const Center(child: Text("No existen Ala deltas disponibles en la tienda"))
          : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                child: _SectionTitle(titleSection: 'Picos disponibles', elementsNumber: state.picosShop.length),
              ),
              GridView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: state.picosShop.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
                itemBuilder: (BuildContext context, int i) {
                  final Shop picoShop = state.picosShop[i];
                  final Color backgroundShopItemColor = replaceShopColorWithDartFormat(picoShop);
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(8.0),
                    child: _ContainerItem(
                      backgroundColor: backgroundShopItemColor, 
                      titleItem: picoShop.displayName!, 
                      imageItem: picoShop.granted![0].images!.icon!, 
                      price: picoShop.price!.finalPrice!
                    ),
                  );
                }
              ),
            ],
          );
        },
      ),
    );
  }
}


class _ContainerItem extends StatelessWidget {
  final Color backgroundColor;
  final String titleItem;
  final String imageItem;
  final int price;

  const _ContainerItem({
    required this.backgroundColor,
    required this.titleItem,
    required this.imageItem,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 14, overflow: TextOverflow.ellipsis);
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor, 
              borderRadius: BorderRadius.circular(10.0)
            ),             
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
              width: double.infinity,
              height: double.infinity,
             child: FadeInImage(
              placeholder: const AssetImage('assets/loading/load.gif'), 
              image: NetworkImage(imageItem, scale: 1),
              fit: BoxFit.fitHeight,
            ),
           ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(bottom: 15, right: 15),
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.18,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image(image:AssetImage('assets/loading/vbuck.png')),
                  ),
                  SizedBox(width: 2.0),
                  Expanded(
                    flex: 1,
                    child: Text('3000', style: textStyle, maxLines: 1),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(titleItem, style: textStyle.copyWith(color: Colors.white70)),
          ),
        )
      ],
    );
  }
}


class _SectionTitle extends StatelessWidget {
  final String titleSection;
  final int elementsNumber;

  const _SectionTitle({
    required this.titleSection,
    required this.elementsNumber
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 9,
          child: Text(titleSection, style: style, maxLines: 2)
        ),
        Expanded(
          flex: 1,
          child: Text(elementsNumber.toString(), style: style, maxLines: 2)
        ),
      ],
    );
  }
}