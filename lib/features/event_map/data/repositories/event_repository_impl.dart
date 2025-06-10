import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
import '../models/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final http.Client client;

  EventRepositoryImpl(this.client);

  @override
  Future<List<Event>> fetchEvents() async {
    final response = await client.get(
      Uri.parse('https://6847d529ec44b9f3493e5f06.mockapi.io/api/v1/events'),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}
