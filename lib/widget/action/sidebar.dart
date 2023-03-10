import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../theme/theme_colors.dart';
import '../../util/constants/app_constants.dart';
import '../../vm/home/home_vm.dart';
import 'sidebar_btn.dart';

class Sidebar extends StatefulWidget {
  final HomeVm? viewModel;
  const Sidebar(this.viewModel, {Key? key}) : super(key: key);

  @override
  SidebarState createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
  HomeVm? vm;
  void handlePageSelected(PageType pageType) => vm!.setCurrentPage(pageType);

  @override
  Widget build(BuildContext context) {
    vm = widget.viewModel;

    return FocusTraversalGroup(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: const BoxDecoration(
          color: ThemeColors.accent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            SidebarBtn(
              Icons.list,
              AppConstants.listTitle,
              pageType: PageType.lists,
              isSelected: vm!.setPage == PageType.lists,
              onPressed: () => handlePageSelected(PageType.lists),
            ),
            const Divider(color: ThemeColors.primaryDark),
            SidebarBtn(
              Icons.search,
              AppConstants.searchTitle,
              pageType: PageType.search,
              isSelected: vm!.setPage == PageType.search,
              onPressed: () => handlePageSelected(PageType.search),
            ),
            const Divider(color: ThemeColors.primaryDark),
            SidebarBtn(
              Icons.favorite,
              AppConstants.likesTitle,
              pageType: PageType.likes,
              isSelected: vm!.setPage == PageType.likes,
              onPressed: () => handlePageSelected(PageType.likes),
            ),
            const Divider(color: ThemeColors.primaryDark),
            SidebarBtn(
              Icons.edit,
              AppConstants.draftTitle,
              pageType: PageType.drafts,
              isSelected: vm!.setPage == PageType.drafts,
              onPressed: () => handlePageSelected(PageType.drafts),
            ),
            const Divider(color: ThemeColors.primaryDark),
            const Spacer(),
            const Divider(color: ThemeColors.primaryDark),
            SidebarBtn(
              Icons.support,
              AppConstants.helpdeskTitle,
              pageType: PageType.helpdesk,
              isSelected: vm!.setPage == PageType.helpdesk,
              onPressed: () => handlePageSelected(PageType.helpdesk),
            ),
            const Divider(color: ThemeColors.primaryDark),
            SidebarBtn(
              Icons.settings,
              AppConstants.settingsTitle,
              pageType: PageType.settings,
              isSelected: vm!.setPage == PageType.settings,
              onPressed: () => handlePageSelected(PageType.settings),
            ),
          ],
        ).padding(bottom: 20).constrained(maxWidth: 280),
      ),
    );
  }
}
