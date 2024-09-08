import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_test/bloc/api/api_bloc.dart';
import 'package:gallery_test/data/services/api_service.dart';
import 'package:gallery_test/presentation/widget/api_bloc_gallery_screen_widget.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ApiBloc(ApiService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ApiBlocGalleryScreenWidget(),
    );
  }
}
