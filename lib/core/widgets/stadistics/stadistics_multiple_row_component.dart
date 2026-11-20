import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';

class StadisticsComponentMultipleRows extends StatelessWidget {
  final List<StadisticSection> listStadistics;
  final double? radius;

  const StadisticsComponentMultipleRows({
    super.key,
    required this.listStadistics,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: kChannelPlayers,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: List.generate(
            (listStadistics.length / 3).ceil(),
            (index) {
              final startIndex = index * 3;
              var endIndex = startIndex + 3;
              if (endIndex > listStadistics.length) {
                endIndex = listStadistics.length;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    for (var i = startIndex; i < endIndex; i++)
                      Expanded(child: listStadistics[i]),
                    for (var i = endIndex - startIndex; i < 3; i++)
                      const Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class StadisticSection extends StatelessWidget {
  final String title;
  final String description;
  final String value;

  const StadisticSection({
    super.key,
    required this.title,
    required this.description,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    const valueStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFeatures: [FontFeature.tabularFigures()],
    );
    const metaStyle = TextStyle(color: Colors.white, fontSize: 11, height: 1.15);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: valueStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(title, style: metaStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(description, style: metaStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
