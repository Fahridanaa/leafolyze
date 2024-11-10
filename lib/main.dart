import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafolyze/config/router.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:leafolyze/blocs/auth/auth_bloc.dart';
// import 'package:leafolyze/blocs/auth/auth_event.dart';
// import 'package:leafolyze/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = await StorageService.init();
  final apiService = ApiService();

  runApp(MainApp(
    storageService: storageService,
    apiService: apiService,
  ));
}

class MainApp extends StatelessWidget {
  final StorageService storageService;
  final ApiService apiService;

  const MainApp({
    super.key,
    required this.storageService,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Leafolyze',
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      routerConfig: goRouter,
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MultiBlocProvider(
  //     providers: [
  //       BlocProvider(
  //         create: (context) => AuthBloc(
  //           AuthRepository(apiService, storageService),
  //         )..add(AuthCheckRequested()),
  //       ),
  //       // Add other BLoCs here
  //     ],
  //     child: MaterialApp.router(
  //       title: 'Leafolyze',
  //       theme: ThemeData(
  //         primarySwatch: Colors.green,
  //         useMaterial3: true,
  //       ),
  //       routerConfig: goRouter,
  //     ),
  //   );
  // }
}
