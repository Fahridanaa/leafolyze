import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafolyze/blocs/auth/auth_bloc.dart';
import 'package:leafolyze/blocs/auth/auth_event.dart';
import 'package:leafolyze/config/router.dart';
import 'package:leafolyze/repositories/auth_repository.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = await StorageService.init();
  final apiService = ApiService(storageService);
  final authRepository = AuthRepository(apiService, storageService);

  runApp(
      MainApp(authRepository: authRepository, storageService: storageService));
}

class MainApp extends StatelessWidget {
  final AuthRepository authRepository;
  final StorageService storageService;

  const MainApp(
      {super.key, required this.authRepository, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository, storageService)
            ..add(AuthCheckRequested()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Leafolyze',
        theme: ThemeData(
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        routerConfig: goRouter,
      ),
    );
  }
}
