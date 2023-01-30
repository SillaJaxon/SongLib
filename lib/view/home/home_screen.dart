import 'package:context_menus/context_menus.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../model/base/book.dart';
import '../../model/base/draft.dart';
import '../../model/base/listed.dart';
import '../../model/base/songext.dart';
import '../../navigator/main_navigator.dart';
import '../../navigator/route_names.dart';
import '../../theme/theme_colors.dart';
import '../../util/constants/app_constants.dart';
import '../../viewmodel/home/home_vm.dart';
import '../../widget/general/app_bar.dart';
import '../../widget/general/inputs.dart';
import '../../widget/general/labels.dart';
import '../../widget/general/list_items.dart';
import '../../widget/progress/line_progress.dart';
import '../../widget/provider/provider_widget.dart';
import '../lists/list_view_popup.dart';
import 'widgets/search_list.dart';
import 'widgets/search_songs.dart';
import 'widgets/search_drafts.dart';
import 'widgets/tabs_manager.dart';

part 'tabs/drafts_tab.dart';
part 'tabs/search_tab.dart';
part 'tabs/song_list_tab.dart';

/// Home screen with 3 tabs of list, search and notes screens
class HomeScreen extends StatefulWidget {
  static const String routeName = RouteNames.homeScreen;
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

@visibleForTesting
class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin
    implements HomeNavigator {
  Size? size;
  TabController? pages;
  int activeIndex = 1;

  @override
  void initState() {
    pages = TabController(vsync: this, length: 3, initialIndex: activeIndex)
      ..addListener(() {
        setState(() {
          activeIndex = pages!.index;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    pages!.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    switch (index) {
      case 0:
        return goToLikes();
      case 1:
        return goToHelpDesk();
      case 2:
        return goToSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeVm>(
      create: () => GetIt.I()..init(this),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) {
        var floatingNavbar = FloatingNavbar(
          currentIndex: 0,
          onTap: onItemTapped,
          fontSize: 1,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: ThemeColors.primary,
          selectedBackgroundColor: ThemeColors.primary,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          items: [
            FloatingNavbarItem(icon: Icons.favorite, title: 'Likes'),
            FloatingNavbarItem(icon: Icons.help, title: 'Help'),
            FloatingNavbarItem(icon: Icons.settings, title: 'Settings'),
          ],
        );
        return Scaffold(
          body: Stack(
            children: [
              TabBarView(
                controller: pages,
                children: [
                  SongListTab(homeVm: viewModel),
                  SearchTab(homeVm: viewModel),
                  DraftsTab(homeVm: viewModel),
                ],
              ),
              TabsIndicator(controller: pages!),
              TabsIcons(controller: pages!),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: floatingNavbar,
        );
      },
    );
  }

  @override
  void goToPresentor() => MainNavigatorWidget.of(context).goToPresentor();

  @override
  void goToEditor() => MainNavigatorWidget.of(context).goToEditor();

  @override
  void goToLikes() => MainNavigatorWidget.of(context).goToLikes();

  @override
  void goToListView() => MainNavigatorWidget.of(context).goToListView();

  @override
  void goToHistories() => MainNavigatorWidget.of(context).goToHistories();

  @override
  void goToHelpDesk() => MainNavigatorWidget.of(context).goToHelpDesk();

  @override
  void goToDonation() => MainNavigatorWidget.of(context).goToDonation();

  @override
  void goToMerchandise() => MainNavigatorWidget.of(context).goToMerchandise();

  @override
  void goToSettings() => MainNavigatorWidget.of(context).goToSettings();
}
