import 'package:get/get.dart';

import '../ui/home/view/home_view.dart';
import '../ui/splash/view/splash_view.dart';

const kDefaultTransition = Transition.rightToLeft;
const kDefaultTransitionDuration = Duration(milliseconds: 500);
final getPages = [
  GetPage(
    name: SplashView.name,
    page: () => const SplashView(),
    transition: kDefaultTransition,
    transitionDuration: kDefaultTransitionDuration,
  ),
  GetPage(
    name: HomeView.name,
    page: () => const HomeView(),
    transition: kDefaultTransition,
    transitionDuration: kDefaultTransitionDuration,
  ),
];
