import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';

/// Marcador superior: la sección y el sujeto que se está consultando.
class Scorebug extends StatelessWidget {
  const Scorebug({
    super.key,
    required this.section,
    required this.subject,
    required this.channel,
    this.trailing,
  });

  final String section;
  final String subject;
  final Color channel;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    const months = <String>[
      'ene', 'feb', 'mar', 'abr', 'may', 'jun',
      'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
    ];
    final day = '${now.day} ${months[now.month - 1]}';
    final quiet = Color.lerp(channel, Colors.white, 0.78)!;

    return ColoredBox(
      color: channel,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(color: kLive, shape: BoxShape.circle),
                  child: SizedBox(width: 8, height: 8),
                ),
                const SizedBox(width: 8),
                Text(
                  'HOY  $day',
                  style: TextStyle(
                    color: quiet,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                const Spacer(),
                Text(
                  section,
                  style: TextStyle(
                    color: quiet,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 6),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeOutCubic,
              transitionBuilder: (child, animation) {
                final slide = Tween<Offset>(
                  begin: const Offset(0.08, 0),
                  end: Offset.zero,
                ).animate(animation);
                return ClipRect(
                  child: SlideTransition(position: slide, child: child),
                );
              },
              child: Text(
                subject,
                key: ValueKey<String>(subject),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: kPrimaryFont,
                  fontSize: 32,
                  height: 1.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Quita el color de un elemento que no es el elegido.
Widget quietItem(Widget child, {required bool selected}) {
  if (selected) return child;
  return ColorFiltered(
    colorFilter: const ColorFilter.matrix(<double>[
      0.2126, 0.7152, 0.0722, 0, 40,
      0.2126, 0.7152, 0.0722, 0, 40,
      0.2126, 0.7152, 0.0722, 0, 40,
      0, 0, 0, 1, 0,
    ]),
    child: child,
  );
}
