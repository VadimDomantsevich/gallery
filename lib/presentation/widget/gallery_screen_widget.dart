import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/bloc/api/api_bloc.dart';
import 'package:gallery_test/data/model/instruction_model.dart';
import 'package:gallery_test/presentation/widget/image_card_widget.dart';
import 'package:gallery_test/presentation/widget/open_image_screen_widget.dart';

class GalleryScreenWidget extends StatelessWidget {
  final Instruction instruction;
  final int currentPage;
  final String controllerText;
  const GalleryScreenWidget(
      {super.key,
      required this.instruction,
      required this.currentPage,
      required this.controllerText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels ==
              notification.metrics.maxScrollExtent) {
            /// When scroll in the end of the list add [UploadEvent]
            /// to upload next page
            context.read<ApiBloc>().add(
                  UploadEvent(
                      currentPage: currentPage + 1, searchText: controllerText),
                );
          }
          return false;
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            /// CrossAxisCount depends on the width of the screen
            crossAxisCount: (MediaQuery.of(context).size.width / 200).floor(),
          ),
          itemCount: instruction.hits.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                // Open image with 1 sec duration to see animation
                Navigator.of(context).push(
                  PageRouteBuilder(
                      transitionDuration: const Duration(seconds: 1),
                      pageBuilder: (_, __, ___) {
                        return OpenImageScreenWidget(hit: instruction.hits[i]);
                      }),
                );
              },

              /// Using [Hero] for animation between screens
              child: Hero(
                tag: instruction.hits[i],
                transitionOnUserGestures: true,

                /// [ImageCardWidget] is widget with image and text
                /// based on [Hit]
                child: ImageCardWidget(hit: instruction.hits[i]),
              ),
            );
          },
        ),
      ),
    );
  }
}
