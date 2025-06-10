import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../event_map/domain/entities/event.dart';

void showCustomBottomSheet(BuildContext context, List<Event> events) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(16),
          child: Material(
            color: Colors.transparent,
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final timeFormatted = DateFormat.jm().format(event.time);
                final subtitle =
                    DateFormat('E').format(event.time) + ' $timeFormatted';
                final icon = index == 0
                    ? Icons.park
                    : index == 1
                        ? Icons.coffee
                        : Icons.music_note;

                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 400 + index * 100),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 10 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      tileColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Icon(icon, color: Colors.white),
                      ),
                      title: Text(event.name,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(subtitle,
                          style: const TextStyle(color: Colors.white70)),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 16, color: Colors.white54),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
