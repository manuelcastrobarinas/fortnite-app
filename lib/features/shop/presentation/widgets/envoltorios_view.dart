import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/core/widgets/widgets.dart';

import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/presentation/bloc/shop_bloc.dart';
import 'package:fortnite_app/features/shop/presentation/replace_color_shops.dart';

class EnvoltoriosView extends StatelessWidget {
  const EnvoltoriosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          final List<Shop> envoltoriosShop = state.wrappersShop;
          if (envoltoriosShop.isEmpty) {
            return const Center(child: Text('No hay envoltorios disponibles en la tienda'));
          }
          return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: SectionTitleShopComponent(titleSection: 'Envoltorios Disponibles', elementsNumber: envoltoriosShop.length),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap  : true,
                  itemCount   : envoltoriosShop.length,
                  itemBuilder : (BuildContext context, int i) {
                    final ShopOfferPreview? preview = shopOfferPreview(envoltoriosShop[i]);
                    if (preview == null) {
                      return const ListTile(title: Text('No disponible'));
                    }
                    return _ListTitleEnvoltorio(
                      description: preview.description,
                      imageItem: preview.imageUrl,
                      title: preview.title,
                      price: preview.price,
                    );
                  },
                ),
              ],
            );
        },
      ),
    );
  }
}

class _ListTitleEnvoltorio extends StatelessWidget {
  final String imageItem;
  final int price;
  final String title;
  final String description;

  const _ListTitleEnvoltorio({
    required this.imageItem,
    required this.price,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle styleTitle = TextStyle(color: Colors.black, fontSize: 18, overflow: TextOverflow.ellipsis);
    return Column(
      children: [
        ListTile(
          leading : Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
            ),
            child:  SizedBox(
              width: double.infinity,
                height: double.infinity,
                child: FadeInImage(
                placeholder: const AssetImage('assets/loading/load.gif'), 
                image: NetworkImage(imageItem, scale: 1),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          trailing: SizedBox(
            height: 100,
            width: 60,
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: Image(image:AssetImage('assets/loading/vbuck.png')),
                ),
                const SizedBox(height: 2.0),
                Expanded(
                  flex: 1,
                  child: Text(price.toString(), style: styleTitle, maxLines: 1),
                ),
              ],
            ),
          ),
          title   : Text(title, style: styleTitle, maxLines: 2),
          subtitle: Text(description),
        ),
        const Padding(
          padding : EdgeInsets.symmetric(horizontal: 20.0),
          child   : Divider(color: Colors.black38),
        )
      ],
    );
  }
}