import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../navigator/main_navigator.dart';
import '../navigator/route_names.dart';
import '../theme/theme_assets.dart';
import '../theme/theme_colors.dart';
import '../util/constants/app_constants.dart';
import '../vm/splash_vm.dart';
import '../widget/provider/provider_widget.dart';

/// Timed Welcome screen
class SplashScreen extends StatefulWidget {
  static const String routeName = RouteNames.splashScreen;

  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

@visibleForTesting
class SplashScreenState extends State<SplashScreen> implements SplashNavigator {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SplashVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Image.asset(ThemeAssets.appIcon, height: 200, width: 200),
              const SizedBox(height: 10),
              const Text(
                AppConstants.appTitle,
                style: TextStyle(
                  fontSize: 50,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.primary,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                AppConstants.appVersion,
                style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 2,
                  color: ThemeColors.primaryDark,
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                    color: ThemeColors.primaryDark, thickness: 2, height: 50),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'with ',
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primary,
                    ),
                  ),
                  Icon(
                    Icons.favorite_rounded,
                    color: ThemeColors.primaryDark,
                  ),
                  Text(
                    ' from',
                    style: TextStyle(
                      fontSize: 30,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    AppConstants.appCredits1,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primaryDark,
                    ),
                  ),
                  Text(
                    ' & ',
                    style: TextStyle(
                      fontSize: 20,
                      color: ThemeColors.primary,
                    ),
                  ),
                  Text(
                    AppConstants.appCredits2,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primaryDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void goToOnboarding() => MainNavigator.of(context).goToOnboarding();

  @override
  void goToHome() => MainNavigator.of(context).goToHome();

  @override
  void goToSelection() => MainNavigator.of(context).goToSelection();
}
