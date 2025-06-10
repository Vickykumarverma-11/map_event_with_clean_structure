import '../../domain/entities/event.dart';

class EventModel extends Event {
  const EventModel({required super.name, required super.time});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'] ?? '',
      time: DateTime.parse(json['time'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'time': time.toIso8601String(),
      };
}
