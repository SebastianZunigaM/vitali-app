import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/splash/presentation/pages/splash_page.dart';
import 'package:vitali/features/auth/presentation/pages/login_page.dart';
import 'package:vitali/features/auth/presentation/pages/register_page.dart';
import 'package:vitali/features/home/presentation/pages/home_page.dart';
import 'package:vitali/features/nutrition/presentation/pages/nutrition_page.dart';
import 'package:vitali/features/hydration/presentation/pages/hydration_page.dart';
import 'package:vitali/features/exercise/presentation/pages/exercise_page.dart';
import 'package:vitali/features/wellbeing/presentation/pages/wellbeing_page.dart';
import 'package:vitali/features/profile/presentation/pages/profile_page.dart';
import 'package:vitali/features/assistant/presentation/pages/assistant_page.dart';
import 'package:vitali/features/settings/presentation/pages/settings_page.dart';
import 'package:vitali/features/onboarding/presentation/pages/onboarding_page.dart';

final routerProvider = Provider<GoRouter>((ref) => _router);

final _router = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.nutrition,
      builder: (context, state) => const NutritionPage(),
    ),
    GoRoute(
      path: AppRoutes.hydration,
      builder: (context, state) => const HydrationPage(),
    ),
    GoRoute(
      path: AppRoutes.exercise,
      builder: (context, state) => const ExercisePage(),
    ),
    GoRoute(
      path: AppRoutes.wellbeing,
      builder: (context, state) => const WellbeingPage(),
    ),
    GoRoute(
      path: AppRoutes.assistant,
      builder: (context, state) => const AssistantPage(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
