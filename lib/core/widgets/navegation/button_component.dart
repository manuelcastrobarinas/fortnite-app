import 'package:flutter/material.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';

class ButtonComponent extends StatelessWidget {
  final Size size;
  final String route;
  final String text;
  final bool isBack;

  const ButtonComponent({
    super.key, 
    required this.size,
    required this.route,
    required this.text,
    this.isBack = true
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: kChannelWeapons,
          foregroundColor: Colors.white,
          minimumSize: Size(size.width * 0.7, 56),
          shape: const StadiumBorder(),
        ),
        onPressed: () => isBack
            ? Navigator.pushNamed(context, route)
            : Navigator.pushReplacementNamed(context, route),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: kPrimaryFont,
          ),
        ),
      ),
    );
  }
}