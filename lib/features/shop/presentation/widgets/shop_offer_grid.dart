import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/widgets.dart';
import 'package:fortnite_app/features/shop/domain/entities/shop_limited.dart';
import 'package:fortnite_app/features/shop/presentation/replace_color_shops.dart';

/// Cuadrícula de la tienda. El scroll es el propio grid, así Flutter solo
/// construye y descarga las fotos que entran en pantalla.
class ShopOfferGrid extends StatelessWidget {
  const ShopOfferGrid({
    super.key,
    required this.offers,
    required this.title,
    required this.emptyMessage,
    this.crossAxisCount = 2,
  });

  final List<Shop> offers;
  final String title;
  final String emptyMessage;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      return Center(child: Text(emptyMessage));
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: SectionTitleShopComponent(
            titleSection: title,
            elementsNumber: offers.length,
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final columns = crossAxisCount == 1
                  ? 1
                  : (constraints.maxWidth / 220).floor().clamp(2, 8);
              return GridView.builder(
                itemCount: offers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: crossAxisCount == 1 ? 1.2 : 0.82,
                ),
                itemBuilder: (context, index) {
                  final preview = shopOfferPreview(offers[index]);
                  final name = offers[index].displayName;
                  return Container(
                    color: kQuiet,
                    margin: const EdgeInsets.all(6),
                    child: preview == null
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    name ?? 'No disponible',
                                    style: const TextStyle(color: kInk),
                                    textAlign: TextAlign.center,
                                  ),
                                  if (name != null)
                                    const Text(
                                      'No disponible',
                                      style: TextStyle(color: kInk),
                                    ),
                                ],
                              ),
                            ),
                          )
                        : _OfferCard(preview: preview),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.preview});

  final ShopOfferPreview preview;

  @override
  Widget build(BuildContext context) {
    const priceStyle = TextStyle(
      color: kInk,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFeatures: [FontFeature.tabularFigures()],
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ColoredBox(
            color: preview.color,
            child: FittedBox(
              fit: BoxFit.contain,
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading/vbuck.png'),
                image: ResizeImage(
                  NetworkImage(preview.imageUrl),
                  width: 280,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  preview.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: kInk, fontSize: 13, height: 1.2),
                ),
              ),
              const SizedBox(width: 6),
              const Image(
                image: AssetImage('assets/loading/vbuck.png'),
                width: 14,
                height: 14,
              ),
              const SizedBox(width: 3),
              Text('${preview.price}', style: priceStyle, maxLines: 1),
            ],
          ),
        ),
      ],
    );
  }
}
