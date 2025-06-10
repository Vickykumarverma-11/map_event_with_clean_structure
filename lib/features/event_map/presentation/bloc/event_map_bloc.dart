import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/event.dart';
import '../../domain/usecases/fetch_events.dart';

part 'event_map_event.dart';
part 'event_map_state.dart';

class EventMapBloc extends Bloc<EventMapEvent, EventMapState> {
  final FetchEvents fetchEvents;

  EventMapBloc({required this.fetchEvents}) : super(EventMapInitial()) {
    on<LoadEventMap>((event, emit) async {
      emit(EventMapLoading());
      try {
        final events = await fetchEvents();
        emit(EventMapLoaded(events: events));
      } catch (e) {
        emit(EventMapError("Failed to load events"));
      }
    });
  }
}
