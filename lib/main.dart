import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_entry_point.dart';
import 'services/service_locator.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/pr-viewer/presentation/bloc/pr_viewer_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> serviceLocator<AuthBloc>()..add(CheckLoginStatus())),
        BlocProvider(create: (_)=> PrViewerBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GitHub PR Viewer',
        theme: ThemeData(
          colorScheme:
          ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  AppEntryPoint(),
      ),
    );
  }
}
