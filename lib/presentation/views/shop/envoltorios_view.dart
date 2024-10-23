import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/components/components.dart';

import 'package:fortnite_app/models/shop/shop_limited.dart';
import '../../../blocs/shop/shop_bloc.dart';

class EnvoltoriosView extends StatelessWidget {
  const EnvoltoriosView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          final List<Shop> envoltoriosShop = state.envoltoriosShop;
          return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: SectionTitleShopComponent(titleSection: 'Envoltorios Disponibles', elementsNumber: envoltoriosShop.length),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller  : controller,
                  shrinkWrap  : true,
                  itemCount   : envoltoriosShop.length,
                  itemBuilder : (BuildContext context, int i) {
                    final Shop envoltorio =  envoltoriosShop[i];
                    return _ListTitleEnvoltorio(
                      description : envoltorio.granted![0].description!,
                      imageItem   : envoltorio.granted![0].images!.icon!,
                      title : envoltorio.displayName!,
                      price : envoltorio.price!.finalPrice!,
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