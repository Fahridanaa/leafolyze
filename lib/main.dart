import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafolyze/blocs/auth/auth_bloc.dart';
import 'package:leafolyze/blocs/auth/auth_event.dart';
import 'package:leafolyze/blocs/history/history_bloc.dart';
import 'package:leafolyze/blocs/history/history_event.dart';
import 'package:leafolyze/blocs/marketplace/marketplace_bloc.dart';
import 'package:leafolyze/blocs/marketplace/marketplace_event.dart';
import 'package:leafolyze/config/router.dart';
import 'package:leafolyze/repositories/article_repository.dart';
import 'package:leafolyze/repositories/auth_repository.dart';
import 'package:leafolyze/repositories/history_repository.dart';
import 'package:leafolyze/repositories/marketplace_repository.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = await StorageService.init();
  final apiService = ApiService(storageService);
  final authRepository = AuthRepository(apiService, storageService);

  runApp(MainApp(
      authRepository: authRepository,
      storageService: storageService,
      apiService: apiService));
}

class MainApp extends StatelessWidget {
  final AuthRepository authRepository;
  final StorageService storageService;
  final ApiService apiService;

  const MainApp(
      {super.key,
      required this.authRepository,
      required this.storageService,
      required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<ApiService>(
          create: (context) => apiService,
        ),
        RepositoryProvider<StorageService>(
          create: (context) => storageService,
        ),
        RepositoryProvider<ArticleRepository>(
          create: (context) => ArticleRepository(apiService),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository, storageService)
              ..add(AuthCheckRequested()),
          ),
          BlocProvider(
            create: (context) => MarketplaceBloc(
              MarketplaceRepository(apiService),
            )..add(LoadProducts()),
          ),
          BlocProvider(
            create: (context) => GambarMLBloc(
              GambarMLRepository(apiService),
            )..add(FetchAllGambarML()),
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
      ),
    );
  }
}
