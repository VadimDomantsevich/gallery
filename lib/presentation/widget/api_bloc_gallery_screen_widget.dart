import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/bloc/api/api_bloc.dart';
import 'package:gallery_test/presentation/widget/gallery_screen_widget.dart';

class ApiBlocGalleryScreenWidget extends StatefulWidget {
  const ApiBlocGalleryScreenWidget({super.key});

  @override
  State<ApiBlocGalleryScreenWidget> createState() =>
      _ApiBlocGalleryScreenWidgetState();
}

class _ApiBlocGalleryScreenWidgetState
    extends State<ApiBlocGalleryScreenWidget> {
  /// Timer for debounce
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    /// Search TextEditingController
    TextEditingController controller = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              right: 16.0,
              left: 16.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 10),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();

                        ///Add [SearchEvent] only after 500ms delay
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          context.read<ApiBloc>().add(SearchEvent(text: value));
                        });
                      },
                    ),
                  ),
                ),
                BlocBuilder<ApiBloc, ApiState>(
                  builder: (BuildContext context, state) {
                    return state.map(initial: (value) {
                      // On Initial state is only CircularProgressIndicator
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }, loaded: (value) {
                      // On Loaded state is gallery
                      return GalleryScreenWidget(
                        instruction: value.response,
                        currentPage: value.currentPage,
                        controllerText: controller.text,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
