import 'package:cinema_flutter/model/repositories/auth_repository.dart';
import 'package:cinema_flutter/shared/extensions/custom_theme_extension.dart';
import 'package:cinema_flutter/shared/routes/routes.dart';
import 'package:cinema_flutter/shared/themes/bloc/theme_bloc.dart';
import 'package:cinema_flutter/shared/themes/bloc/theme_event.dart';
import 'package:cinema_flutter/shared/themes/bloc/theme_state.dart';
import 'package:cinema_flutter/view/admin/main/admin_main.dart';
import 'package:cinema_flutter/view/auth_page/auth_page.dart';
import 'package:cinema_flutter/view_model/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const CinemaApp());
}

class CinemaApp extends StatefulWidget {
  const CinemaApp({super.key});

  @override
  State<CinemaApp> createState() => _CinemaAppState();
}

class _CinemaAppState extends State<CinemaApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()..add(LoadTheme())),
        BlocProvider(
          create: (_) =>
              AuthBloc(authenticationRepository: AuthRepository.instance)
                ..add(AuthenticationSubscriptionRequested()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            theme: lightTheme,
            onGenerateRoute: Routes.onGenerateRoute,
            darkTheme: darkTheme,
            home: const AuthPage(),
          );
        },
      ),
    );
  }
}
