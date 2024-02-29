import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/di/di.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:frontend/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DI.build();

  DI.logger().i("Dependencies Initialized With Config : ${const String.fromEnvironment('DI_ENV')}");

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  DI.logger().i("Base Url : ${DI.get<String>(name: 'BaseUrl')}");

  runApp(const PlatePalApp());
}

class PlatePalApp extends StatelessWidget {
  const PlatePalApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) => MaterialApp(
          title: 'PlatePal',
          theme: materialLight,
          darkTheme: materialDark,
          themeMode: state.themeMode,
          debugShowCheckedModeBanner: false,
          routes: _routes,
          initialRoute: '/',
          builder: (context, widget) => RootBlocProvider(child: widget!),
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> get _routes {
    return {
      '/': (context) => const ScreenWrapper(child: SplashScreen()),
      '/home': (context) => const ScreenWrapper(child: HomeScreen()),
      '/preferences': (context) => const ScreenWrapper(child: PreferencesScreen()),
      '/chat': (context) => const ScreenWrapper(child: ChatScreen()),
      // '/inventory': (context) => const ScreenWrapper(child: TitleScreen()),
      // '/recipe': (context) => ScreenWrapper(child: FriendsScreen()),
      // '/profile': (context) => ScreenWrapper(child: ProfileScreen()),
    };
  }
}
