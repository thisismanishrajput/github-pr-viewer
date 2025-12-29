import 'package:github_pr_viewer/features/pr-viewer/presentation/bloc/pr_viewer_bloc.dart';
import 'package:github_pr_viewer/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/pr-viewer/presentation/view/pr_viewer_screen.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'GITHUB PR-Viewer',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (context) => PrViewerBloc(),
          child: PullRequestScreen(),
        )
    );
  }
}


