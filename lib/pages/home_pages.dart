import 'package:flutter/material.dart';
import 'package:json_placehlder/pages/tabs/albums_tabs.dart';
import 'package:json_placehlder/pages/tabs/comments_tabs.dart';
import 'package:json_placehlder/pages/tabs/photos_tabs.dart';
import 'package:json_placehlder/pages/tabs/posts_tabs.dart';
import 'package:json_placehlder/pages/tabs/todo_tabs.dart';
import 'package:json_placehlder/pages/tabs/users_tabs.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          title: const Text(
            'JSONPlaceholder API',
            style: TextStyle(
              color: Color(0xFF252A34),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE5E8ED), width: 1),
                ),
              ),
              child: const TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: Color(0xFF526B9A),
                unselectedLabelColor: Color(0xFF737B89),
                indicatorColor: Color(0xFF526B9A),
                indicatorWeight: 2.5,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                tabs: [
                  Tab(
                    icon: Icon(Icons.article_outlined, size: 18),
                    text: 'Posts',
                  ),
                  Tab(
                    icon: Icon(Icons.chat_bubble_outline, size: 18),
                    text: 'Comments',
                  ),
                  Tab(
                    icon: Icon(Icons.photo_library_outlined, size: 18),
                    text: 'Albums',
                  ),
                  Tab(
                    icon: Icon(Icons.image_outlined, size: 18),
                    text: 'Photos',
                  ),
                  Tab(
                    icon: Icon(Icons.check_circle_outline, size: 18),
                    text: 'Todos',
                  ),
                  Tab(
                    icon: Icon(Icons.people_outline, size: 18),
                    text: 'Users',
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            PostsTabs(),
            CommentsTabs(),
            AlbumsTabs(),
            PhotosTabs(),
            TodoTabs(),
            UsersTabs(),
          ],
        ),
      ),
    );
  }
}
