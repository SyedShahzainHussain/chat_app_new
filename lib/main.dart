import 'package:chat_app_new/firebase_options.dart';
import 'package:chat_app_new/view/signup/sign_up.dart';
import 'package:chat_app_new/view/splash_screen/splash_screen.dart';
import 'package:chat_app_new/view_model/fetch_user_data/fetch_user_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'config/context_utils.dart';
import 'view_model/check_authentication_bloc/check_authentication_bloc.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FetchUserBloc()),
        BlocProvider(create: (_) => CheckAuthenticationBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        navigatorKey: SContextUtils.navaigatorKey,
        theme: ThemeData(
          useMaterial3: true,
        ).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 63, 17, 177),
            ),
            cardTheme: const CardTheme().copyWith(
                color: Theme.of(context).colorScheme.primaryContainer,
                margin: const EdgeInsets.all(12.0))),
        home: const SplashScreen(),
      ),
    );
  }
}
