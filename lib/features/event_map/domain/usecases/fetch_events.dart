import '../entities/event.dart';
import '../repositories/event_repository.dart';

class FetchEvents {
  final EventRepository repository;

  FetchEvents(this.repository);

  Future<List<Event>> call() async => await repository.fetchEvents();
}
