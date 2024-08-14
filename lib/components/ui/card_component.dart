import 'package:flutter/material.dart';

class CustomCardComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final int price;
  final Color color;
  final String urlImage;

  const CustomCardComponent({
    super.key, 
    required this.title,
    required this.subtitle,
    required this.price,
    required this.color,
    required this.urlImage
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const TextStyle titleStyle   = TextStyle(color: Colors.white, fontSize: 30);
    const TextStyle priceStyle   = TextStyle(color: Colors.white, fontSize: 24);
    const TextStyle packageStyle = TextStyle(color: Colors.white, fontSize: 28);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
                width: size.width * 0.6,
                height: double.infinity,
               child: FadeInImage(
                placeholder: const AssetImage('assets/loading/load.gif'), 
                image: NetworkImage(urlImage, scale: 1),
                fit: BoxFit.fitHeight,
              ),
             ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: size.width * 0.28,
                child: Text(title, style: titleStyle, overflow: TextOverflow.ellipsis, maxLines: 6,)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20.0),
            child: Align(
              alignment: Alignment.topRight,
              child:   Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.22,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      const Image(image:AssetImage('assets/loading/vbuck.png')),
                      const SizedBox(width: 2.0),
                      Expanded(
                        child: Text('$price', style: priceStyle, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0, left: 20.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: size.width * 0.55,
                child: Text(subtitle, style: packageStyle, overflow: TextOverflow.ellipsis, maxLines: 3)
              ),
            ),
          ),
        ],
      ),
    );
  }
}