import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FancyBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FancyBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(
        icon: Icons.chat_outlined,
        activeIcon: Icons.chat_rounded,
        label: 'Chats',
        index: 0,
      ),
      _NavItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: 'Profile',
        index: 1,
      ),
    ];

    return Container(
      height: 65,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items.map((item) {
          final isSelected = currentIndex == item.index;
          return _buildNavItem(context, item, isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, _NavItem item, bool isSelected) {
    return GestureDetector(
      onTap: () => onTap(item.index),
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? item.activeIcon : item.icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                item.label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate(target: isSelected ? 1 : 0).fadeIn().slideX(),
            ],
          ],
        ),
      ).animate(target: isSelected ? 1 : 0).scale(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1, 1),
            duration: 150.ms,
            curve: Curves.easeOut,
          ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
  });
}
