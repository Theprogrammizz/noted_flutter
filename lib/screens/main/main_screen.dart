import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:noted_flutter/providers/nav/nav_provider.dart';
import 'package:noted_flutter/screens/main/add_notes_screen.dart';
import 'package:noted_flutter/screens/main/home_screen.dart';
import 'package:noted_flutter/screens/main/profile_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final List<Widget> pages = const [HomeScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navProvider);
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        color: Color(0xFF173200),
        child: GNav(
          backgroundColor: Color(0xFF173200),
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromARGB(255, 34, 80, 36),
          padding: EdgeInsets.all(16),
          selectedIndex: currentIndex,
          onTabChange: (index) {
            ref.read(navProvider.notifier).updateIndex(index);
          },
          gap: 8,
          tabs: [
            GButton(icon: Icons.notes, text: "Notes"),
            GButton(icon: Icons.person, text: "Profile"),
          ],
        ),
      ),

      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotesScreen(),));
              },
              backgroundColor: Color(0xFF173200),
              elevation: 0,
              child: Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
