import 'package:flutter/material.dart';
import 'package:fortnite_app/components/components.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
     final List<Widget> cards = [
      const CustomCardComponent(title: "Boba Fett", price: 1000, subtitle: "hola ,undo este es un escrito para ver que tan largo sale el", color: Colors.blue, urlImage: "https://media.fortniteapi.io/images/22952fe4c653be06ed464eede50dd6a2/full_featured.png",),
      const CustomCardComponent(title: "qqqqq",     price: 1000, subtitle: "hola ,undo", color: Colors.red, urlImage: "https://media.fortniteapi.io/images/displayAssets/v2/MAX/DAv2_CID_A_338_F_Galactic_HN9DO/MI_CID_A_338_F_Galactic.png",),
      const CustomCardComponent(title: "eeeeee",    price: 1000, subtitle: "hola ,undo", color: Colors.amber, urlImage: "https://media.fortniteapi.io/images/displayAssets/v2/MAX/DAv2_Character_TireSwing/MI_Character_TireSwing.png",),
      const CustomCardComponent(title: "rrrrr",     price: 1000, subtitle: "hola ,undo", color: Colors.purple, urlImage: "https://media.fortniteapi.io/images/displayAssets/v2/MAX/DAv2_Bundle_Featured_GallonBag/MI_Bundle_BB_Featured_GallonBag.png",),
      const CustomCardComponent(title: "zzzzz",     price: 1000, subtitle: "hola ,undo", color: Colors.green, urlImage: "https://media.fortniteapi.io/images/eda4913-c868e30-42291e9-4a1ddcf/full_featured.png",),
      const CustomCardComponent(title: "ddddd",     price: 1000, subtitle: "hola ,undo", color: Colors.brown, urlImage: "https://media.fortniteapi.io/images/22952fe4c653be06ed464eede50dd6a2/full_featured.png",),
    ];

    return SingleChildScrollView(
      child: Column(    
        children: [
          const TagsMultipleChipSelectorComponent(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: _SectionTitle(),
          ),
          CardSlider(
            cards: cards,
            cardHeight : 1.1,
            cardWidth  : 0.75,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            height: 200,
            width : double.infinity,
            child: const Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _LeftContainerItem(),
                ),
                Expanded(
                  flex: 3,
                  child: _RightContainerItems(),
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}


class _RightContainerItems extends StatelessWidget {
  const _RightContainerItems();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          flex: 1,
          child: _RightUpContainerItems(),
        ),
        Expanded(
          flex: 1,
          child: _RightDownContainerItem(),
        ),
      ],
    );
  }
}

class _RightDownContainerItem extends StatelessWidget {
  const _RightDownContainerItem();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _ContainerItem(
            backgroundColor: Colors.blueAccent[100]!,
            imageItem: 'asdasdadda',
            price: 2000,
            titleItem: 'hola mundo',
          )
        ),
      ],
    );
  }
}

class _RightUpContainerItems extends StatelessWidget {
  const _RightUpContainerItems();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child:  _ContainerItem(
            backgroundColor: Colors.blueAccent[100]!,
            imageItem: 'asdasdadda',
            price: 1000,
            titleItem: 'hola mundo 2',
          )
        ),
        Expanded(
          flex: 1,
          child: _ContainerItem(
            backgroundColor: Colors.blueAccent[100]!,
            imageItem: 'asdasdadda',
            price: 5000,
            titleItem: 'hola mundo3',
          )
        ),
      ],
    );
  }
}

class _LeftContainerItem extends StatelessWidget {
  const _LeftContainerItem();

  @override
  Widget build(BuildContext context) {
    return _ContainerItem(
      backgroundColor: Colors.purple[200]!,
      imageItem: 'asdsada',
      price: 700,
      titleItem: 'Pico como raro',
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
    const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 16);
    String url = "https://media.fortniteapi.io/images/8021b5d65a1e177487b6608ad3f37824/transparent.png";
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
              image: NetworkImage(url, scale: 1),
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
                    child: Text('3000', style: textStyle),
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