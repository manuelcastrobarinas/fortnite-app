import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';

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
    return SizedBox(
      child: Center(
        child: Container(
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const LinearGradient(
              stops: [
                0.05,
                1
              ],
              colors: [
                kPrimaryColorVariant,
                kPrimaryColor
              ]
            ),
            boxShadow: const [
              BoxShadow(
                color: kShadowColor,
                blurRadius: 8,
                offset: Offset(0, 12),
              )
            ]
          ),
          child: MaterialButton(
            padding : const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            minWidth: size.width * 0.7,
            height  : 60,
            elevation : 0,
            shape : const  StadiumBorder(),
            child : Text(
              text, 
              style: const TextStyle(
                color: Colors.white, 
                fontSize: 18, 
                fontFamily: 'fortnite'
              )
            ),
            onPressed: () =>  isBack == true ? Navigator.pushNamed(context, route) : Navigator.pushReplacementNamed(context, route)
          ),
        ),
      )
    );
  }
}