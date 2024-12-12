import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/components/components.dart';
import 'package:fortnite_app/utils/shop/replace_color_shops.dart';

import '../../../blocs/shop/shop_bloc.dart';
import '../../../models/shop/shop_limited.dart';
class MusicaView extends StatefulWidget {
  const MusicaView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MusicaViewState createState() => _MusicaViewState();
}

class _MusicaViewState extends State<MusicaView> {
  final ScrollController _scrollController = ScrollController();
  final int _itemsPerPage = 20;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    context.read<ShopBloc>().add(const OnLoadMoreElementsEvent(page: 0, itemsPerPage: 0));
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==_scrollController.position.maxScrollExtent) {
      context.read<ShopBloc>().add(OnLoadMoreElementsEvent(page: _currentPage + 1, itemsPerPage: _itemsPerPage +20));
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        return (state.musicaShop.isEmpty)
            ? const Center(child: Text("No existen gestos disponibles en la tienda"))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    child: SectionTitleShopComponent(
                      titleSection: 'Pistas disponibles',
                      elementsNumber: state.musicaShop.length,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: state.musicaShop.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int i) {
                        final Shop canciones = state.musicaShop[i];
                        final Color backgroundShopItemColor = replaceShopColorWithDartFormat(canciones);
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(8.0),
                          height: 50,
                          width: 50,
                          child: _ContainerItem(
                            backgroundColor: backgroundShopItemColor,
                            titleItem: canciones.displayName!,
                            imageItem: canciones.granted![0].images!.icon!,
                            price: canciones.price!.finalPrice!,
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
      },
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
    const TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis);
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor, 
              borderRadius: BorderRadius.circular(10)
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
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Image(image:AssetImage('assets/loading/vbuck.png')),
                  ),
                  const SizedBox(width: 2.0),
                  Expanded(
                    flex: 1,
                    child: Text(price.toString(), style: textStyle, maxLines: 1),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding : const EdgeInsets.only(left: 15, top: 15),
          child   : Align(
            alignment : Alignment.topLeft,
            child: Text(titleItem, style: textStyle.copyWith(color: Colors.black), maxLines: 3),
          ),
        )
      ],
    );
  }
}