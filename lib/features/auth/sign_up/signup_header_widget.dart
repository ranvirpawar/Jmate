import 'package:flutter/material.dart';

class form_header_widget extends StatelessWidget {
  const form_header_widget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(image), height: size.height * 0.2),
        Text(title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
