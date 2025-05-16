import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'pages/users_page.dart';
import 'pages/rdv_page.dart';
import 'pages/videos_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;
  double _opacity = 1;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      _opacity = (100 - _scrollPosition) / 100;
      if (_opacity < 0) _opacity = 0;
      if (_opacity > 1) _opacity = 1;
    });
  }

  Widget _getCurrentPage() {
    switch (_selectedIndex) {
      case 0:
        return const UsersPage();
      case 1:
        return const RdvPage();
      case 2:
        return const VideosPage();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is UserScrollNotification) {
          FocusScope.of(context).unfocus();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: const Text(
            'Espace Admin',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                print('Déconnexion');
              },
              tooltip: 'Déconnexion',
            ),
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(milliseconds: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bienvenue  👑',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Que souhaites-tu faire aujourd\'hui ?',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _getCurrentPage(),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: _scrollController,
                builder: (context, child) {
                  double offset = _scrollController.hasClients
                      ? _scrollController.offset
                      : 0;
                  double hide = (offset > 30) ? 1 : 0;
                  return AnimatedSlide(
                    offset: Offset(0, hide),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: child,
                  );
                },
                child: CurvedNavigationBar(
                  backgroundColor: Colors.transparent,
                  color: Colors.red[200]!,
                  buttonBackgroundColor: Colors.red,
                  height: 60,
                  index: _selectedIndex,
                  items: const [
                    Icon(Icons.people, size: 30, color: Colors.white),
                    Icon(Icons.calendar_month, size: 30, color: Colors.white),
                    Icon(Icons.video_collection, size: 30, color: Colors.white),
                  ],
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
