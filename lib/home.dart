import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skill_test_patch/constants.dart';
import 'package:flutter_skill_test_patch/pages/discover_page.dart';

import 'data/app_state_data.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appStateNotifier);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: DiscoverPage(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: Offset(0, -20),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: state.selectedIndex,
          onTap: (index) => ref.read(appStateNotifier.notifier).setSelectedIndex(index),
          selectedItemColor: ConstantColors.accent,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: 'Discover',
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(Icons.shopping_bag_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Sell',
              icon: Icon(Icons.add_circle_outline),
            ),
            BottomNavigationBarItem(
              label: 'Inbox',
              icon: Icon(Icons.inbox_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }
}