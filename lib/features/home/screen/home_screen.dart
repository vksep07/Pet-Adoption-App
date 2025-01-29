import 'package:flutter/material.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/app_constants.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/features/history/history_screen.dart';
import 'package:pet_adoption/features/home/widgets/bottombar_item.dart';
import 'package:pet_adoption/features/home/model/bottom_bar_model.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int _activeTab = 0;
  List<BottomBarModel> barItems = getBarList();

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: AppConstants.ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      _activeTab = index;
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBgColor,
      body: _buildPage(),
      floatingActionButton: _buildBottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        barItems.length,
        (index) {
          if (index == 1) {
            return _buildAnimatedPage(const HistoryPage());
          }
          return _buildAnimatedPage(barItems[index].page);
        },
      ),
    );
  }

  Widget _buildBottomBar() {
    double height = 55;
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space24,
        vertical:  AppSpacing.space20,
      ),
      decoration: BoxDecoration(
        color: AppColors.bottomBarColor,
        borderRadius: BorderRadius.circular(AppSpacing.space20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          barItems.length,
          (index) => BottomBarItem(
            _activeTab == index
                ? barItems[index].activeIcon
                : barItems[index].inActiveIcon,
            isActive: _activeTab == index,
            activeColor: AppColors.primary,
            onTap: () => onPageChanged(index),
          ),
        ),
      ),
    );
  }
}
