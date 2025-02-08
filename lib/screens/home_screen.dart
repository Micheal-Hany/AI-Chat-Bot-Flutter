import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/providers/chat_provider.dart';
import 'package:chatbotapp/screens/chat_history_screen.dart';
import 'package:chatbotapp/screens/chat_screen.dart';
import 'package:chatbotapp/screens/profile_screen.dart';
import 'package:chatbotapp/widgets/fancy_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, _) {
        return Scaffold(
          body: PageView(
            controller: chatProvider.pageController,
            onPageChanged: chatProvider.setCurrentIndex,
            children: const [
              ChatHistoryScreen(),
              ChatScreen(),
              ProfileScreen(),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: FancyBottomNav(
            currentIndex: chatProvider.currentIndex,
            onTap: (index) {
              chatProvider.setCurrentIndex(index);
              chatProvider.pageController.jumpToPage(index);
            },
          ),
        );
      },
    );
  }
}
