import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:marketlyze_1/features/authentication/main_authentication_screen.dart';
import 'package:marketlyze_1/features/authentication/repository/authentication_repository.dart';
import 'package:marketlyze_1/features/main_screen.dart';

final routerProvider = Provider(
  (ref) {
    // ref.watch(authState);
    return GoRouter(
      initialLocation: "/MainScreen",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != MainAuthenticationScreen.routeURL) {
            // 로그인이 되어있지 않을때 메인화면으로 이동
            // return "/MainScreen";

            // 로그인이 되어있지 않을떄 회원가입 화면으로 이동
            return MainAuthenticationScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: MainAuthenticationScreen.routeName,
          path: MainAuthenticationScreen.routeURL,
          builder: (context, state) => const MainAuthenticationScreen(),
        ),
        // GoRoute(
        //   name: SelectLoginScreen.routeName,
        //   path: SelectLoginScreen.routeURL,
        //   builder: (context, state) => const SelectLoginScreen(),
        // ),
        // GoRoute(
        //   name: MainLoginScreen.routeName,
        //   path: MainLoginScreen.routeURL,
        //   builder: (context, state) => const MainLoginScreen(),
        // ),
        // GoRoute(
        //   name: SelectSignUpScreen.routeName,
        //   path: SelectSignUpScreen.routeURL,
        //   builder: (context, state) => const SelectSignUpScreen(),
        // ),
        // GoRoute(
        //   name: UsernameScreen.routeName,
        //   path: UsernameScreen.routeURL,
        //   builder: (context, state) => const UsernameScreen(),
        // ),
        // GoRoute(
        //   name: EmailPasswordScreen.routeName,
        //   path: EmailPasswordScreen.routeURL,
        //   builder: (context, state) {
        //     final args = state.extra as EmailPasswordScreenArg;
        //     return EmailPasswordScreen(username: args.username);
        //   },
        // ),
        // GoRoute(
        //   name: BirthdayScreen.routeName,
        //   path: BirthdayScreen.routeURL,
        //   builder: (context, state) => const BirthdayScreen(),
        // ),
        GoRoute(
          name: MainScreen.routeName,
          path: MainScreen.routeURL,
          builder: (context, state) => const MainScreen(),
        ),
        // GoRoute(
        //   name: MainHome.routeName,
        //   path: MainHome.routeURL,
        //   builder: (context, state) => const MainHome(),
        // ),
        // GoRoute(
        //   name: MainSearch.routeName,
        //   path: MainSearch.routeURL,
        //   builder: (context, state) => const MainSearch(),
        // ),
        // GoRoute(
        //   name: MainReview.routeName,
        //   path: MainReview.routeURL,
        //   builder: (context, state) => const MainReview(),
        // ),
        // GoRoute(
        //   name: MainOther.routeName,
        //   path: MainOther.routeURL,
        //   builder: (context, state) => const MainOther(),
        // ),
        // GoRoute(
        //   name: MainProfile.routeName,
        //   path: MainProfile.routeURL,
        //   builder: (context, state) => const MainProfile(),
        // ),
      ],
    );
  },
);
