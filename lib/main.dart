import 'package:ecmmerce/apiservice.dart';
import 'package:ecmmerce/bloc/bloc/auth_bloc.dart';
import 'package:ecmmerce/bloc/bloc/auth_event.dart';
import 'package:ecmmerce/bloc/bloc/auth_state.dart';
import 'package:ecmmerce/bloc/bloc/categories_bloc.dart';
import 'package:ecmmerce/bloc/bloc/categories_event.dart';
import 'package:ecmmerce/bloc/product_bloc.dart';
import 'package:ecmmerce/screens/login.dart';
import 'package:ecmmerce/screens/mainscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthBloc authBloc = AuthBloc(ApiService());

  @override
  Widget build(BuildContext context) {
  
    final GoRouter router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const Mainscreen(),
        ),
      ],
      redirect: (context, state) {
        final authState = authBloc.state;
        final isLoggingIn = state.matchedLocation == '/login';

        if (authState is Authenticated && isLoggingIn) return '/home';
        if (authState is Unauthenticated && !isLoggingIn) return '/login';
        return null;
      },
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authBloc),
        BlocProvider(
            create: (_) => ProductBloc(ApiService())..add(LoadProducts())),
        BlocProvider(
            create: (_) =>
                CategoriesBloc(ApiService())..add(FetchCategories())),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            router.go('/home');
          } else if (state is Unauthenticated) {
            router.go('/login');
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xffD1C000),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xffD1C000)),
            useMaterial3: true,
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
