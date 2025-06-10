import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final VoidCallback onFireTap;
  final Animation<double> pulseAnimation;
  final Animation<Offset> navOffset;

  const BottomNav({
    super.key,
    required this.onFireTap,
    required this.pulseAnimation,
    required this.navOffset,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: navOffset,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.search, color: Colors.orange),
            ScaleTransition(
              scale: pulseAnimation,
              child: GestureDetector(
                onTap: onFireTap,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.local_fire_department,
                      color: Colors.white),
                ),
              ),
            ),
            const Icon(Icons.settings, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
