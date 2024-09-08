import 'package:flutter/material.dart';
import 'package:gallery_test/data/model/instruction_model.dart';

class OpenImageScreenWidget extends StatelessWidget {
  final Hit hit;
  const OpenImageScreenWidget({super.key, required this.hit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          /// Using [Hero] for animation between screens
          child: Hero(
            tag: hit,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                hit.webformatUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
