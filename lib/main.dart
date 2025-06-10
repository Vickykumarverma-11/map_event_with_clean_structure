// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/event_map/data/repositories/event_repository_impl.dart';
import 'features/event_map/domain/usecases/fetch_events.dart';
import 'features/event_map/presentation/bloc/event_map_bloc.dart';

import 'features/event_map/presentation/screens/event_maps_screen.dart';

void main() {
  final client = http.Client();
  final repository = EventRepositoryImpl(client);
  final fetchEvents = FetchEvents(repository);

  runApp(MyApp(fetchEvents: fetchEvents));
}

class MyApp extends StatelessWidget {
  final FetchEvents fetchEvents;

  const MyApp({super.key, required this.fetchEvents});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Map App',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (_) =>
            EventMapBloc(fetchEvents: fetchEvents)..add(LoadEventMap()),
        child: const EventMapScreen(),
      ),
    );
  }
}
