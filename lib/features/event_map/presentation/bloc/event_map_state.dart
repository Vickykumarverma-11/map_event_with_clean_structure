part of 'event_map_bloc.dart';

abstract class EventMapState extends Equatable {
  const EventMapState();

  @override
  List<Object> get props => [];
}

class EventMapInitial extends EventMapState {}

class EventMapLoading extends EventMapState {}

class EventMapLoaded extends EventMapState {
  final List<Event> events;

  const EventMapLoaded({required this.events});

  @override
  List<Object> get props => [events];
}

class EventMapError extends EventMapState {
  final String message;

  const EventMapError(this.message);

  @override
  List<Object> get props => [message];
}
