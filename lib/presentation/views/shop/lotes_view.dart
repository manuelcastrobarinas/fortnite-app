import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/components/components.dart';
import 'package:fortnite_app/models/shop/shop_limited.dart';

import '../../../blocs/shop/shop_bloc.dart';

class LotesView extends StatelessWidget {
  const LotesView({super.key});

  @override
  Widget build(BuildContext context) {
    List<CustomCardComponent> cardsList = [];

    List<CustomCardComponent> setShopCardsComponents({required List<CustomCardComponent> cardsList, required List<Shop> shop}) {
        for (var shopElement  in shop) {
        cardsList.add(
          CustomCardComponent(
            urlImage: shopElement.displayAssets?[0].url ?? shopElement.granted![0].images!.icon!,
            subtitle: shopElement.displayDescription ?? 'Descripcion no disponible', 
            title   : shopElement.displayName ?? 'Nombre no disponible', 
            price   : shopElement.price?.finalPrice ?? shopElement.price?.regularPrice ?? shopElement.price?.floorPrice ?? 2000, 
            color   : (shopElement.colors?.color1 != null)
                ?  Color(int.parse(shopElement.colors!.color1!.replaceFirst('#', '0xFF')))
              : (shopElement.colors?.color2 != null) 
                ? Color(int.parse(shopElement.colors!.color2!.replaceFirst('#', '0xFF'))) 
              : (shopElement.colors?.color3 != null)
                ? Color(int.parse(shopElement.colors!.color3!.replaceFirst('#', '0xFF'))) 
              :Colors.black,
          )
        );
      }
      return cardsList;
    }

    return SingleChildScrollView(
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (cardsList.isEmpty) {
            setShopCardsComponents(cardsList: cardsList, shop: state.loteDe5ObjetosShop);
          }
          final ShopBloc shopBloc = BlocProvider.of<ShopBloc>(context);
          return Column(    
              children: [        
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: _SectionTitle(),
                ),
                CardSlider(
                  cards: cardsList,
                  cardHeight : 0.85,
                  cardWidth  : 0.75,
                  setIndexSelectedItem: shopBloc.setIndexSelectedItemShop,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  height: 200,
                  width : double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: _LeftContainerItem(//Evaluamos que el index se posicione en 0 cunado tenga el largo del arreglo
                          imageUrl: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted![0].images!.icon!,
                          titleArticle: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted![0].name!,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: _RightContainerItems(
                          titleItemTwo: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted?[1].name,
                          titleItemThree: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted?[2].name,
                          titleItemFour: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted?[3].name,
                          imageUrlTwo: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted?[1].images!.icon,
                          imageUrlThree: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted?[2].images!.icon,
                          imageUrlFour: state.loteDe5ObjetosShop[state.indexShop == state.loteDe5ObjetosShop.length ? 0 : state.indexShop].granted?[3].images!.icon,
                        ),
                      ),
                    ],
                  ),
                )
              ]
            );
        },
      ),
    );
  }
}


class _RightContainerItems extends StatelessWidget {
  final String? imageUrlTwo;
  final String? titleItemTwo;
  final String? imageUrlThree;
  final String? titleItemThree;
  final String? imageUrlFour;
  final String? titleItemFour;

  const _RightContainerItems({
    required this.imageUrlTwo, 
    required this.titleItemTwo, 
    required this.imageUrlThree, 
    required this.titleItemThree,
    required this.imageUrlFour,
    required this.titleItemFour,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (imageUrlThree == null && imageUrlTwo == null && titleItemThree == null && titleItemTwo == null) 
        ? const SizedBox()
        : Expanded(
          flex: 1,
          child: _RightUpContainerItems(
            imageUrlTwo   : imageUrlTwo,
            titleItemTwo  : titleItemTwo,
            imageUrlThree : imageUrlThree,
            titleItemThree: titleItemThree,
          ),
        ),
        (titleItemFour == null || imageUrlFour == null)  
        ? const SizedBox()
        : Expanded(
          flex: 1,
          child: _RightDownContainerItem(
            imageUrlFour: imageUrlFour,
            titleItemFour: titleItemFour,
          ),
        ),
      ],
    );
  }
}

class _RightDownContainerItem extends StatelessWidget {

  final String? titleItemFour;
  final String? imageUrlFour;

  const _RightDownContainerItem({
    required this.imageUrlFour, required this.titleItemFour
  });

  @override
  Widget build(BuildContext context) {
    return (titleItemFour == null || imageUrlFour == null) 
    ? const SizedBox()
    : Row(
        children: [
        Expanded(
          flex: 1,
          child: _ContainerItem(
            backgroundColor: Colors.blueAccent[100]!,
            imageItem: imageUrlFour!,
            price: 2000,
            titleItem: titleItemFour!,
          )
        ),
      ],
    );
  }
}

class _RightUpContainerItems extends StatelessWidget {

  final String? titleItemTwo;
  final String? imageUrlTwo;
  final String? titleItemThree;
  final String? imageUrlThree;

  const _RightUpContainerItems({
    required this.titleItemTwo, 
    required this.imageUrlTwo, 
    required this.titleItemThree, 
    required this.imageUrlThree,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (imageUrlTwo == null || titleItemTwo == null ) 
          ? const SizedBox()
          : Expanded(
          flex: 1,
          child:  _ContainerItem(
            backgroundColor: Colors.blueAccent[100]!,
            imageItem: imageUrlTwo!,
            price: 1000,
            titleItem: titleItemTwo!,
          )
        ),
        (imageUrlThree == null || titleItemThree == null ) 
          ? const SizedBox()
          : Expanded(
          flex: 1,
          child: _ContainerItem(
            backgroundColor: Colors.blueAccent[100]!,
            imageItem: imageUrlThree!,
            price: 5000,
            titleItem: titleItemThree!,
          )
        ),
      ],
    );
  }
}

class _LeftContainerItem extends StatelessWidget {

  final String titleArticle;
  final String imageUrl;
  
  const _LeftContainerItem({
    required this.titleArticle,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return _ContainerItem(
      backgroundColor: Colors.purple[200]!,
      imageItem: imageUrl,
      price: 700,
      titleItem: titleArticle,
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
            margin: const EdgeInsets.all(5.0),
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor, 
              borderRadius: BorderRadius.circular(15)
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

  const _SectionTitle();
  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis);
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Text("Destacados", style: style, maxLines: 2)
        ),
        Expanded(
          flex: 1,
          child: Text("20", style: style, maxLines: 2)
        ),
      ],
    );
  }
}