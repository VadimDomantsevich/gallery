import 'package:flutter/material.dart';
import 'package:gallery_test/data/model/instruction_model.dart';

class ImageCardWidget extends StatelessWidget {
  final Hit hit;
  const ImageCardWidget({super.key, required this.hit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 210,
        width: 200,
        child: Column(
          children: [
            SizedBox(
              height: 140,
              width: 200,
              child: Image.network(
                hit.webformatUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 20,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          size: 20,
                          color: Color.fromARGB(255, 217, 92, 134),
                        ),
                        Text(
                          '${hit.likes}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          size: 20,
                          color: Color.fromARGB(255, 217, 92, 134),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            '${hit.views}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
