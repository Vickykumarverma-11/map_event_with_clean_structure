part of 'event_map_bloc.dart';

abstract class EventMapEvent extends Equatable {
  const EventMapEvent();

  @override
  List<Object> get props => [];
}

class LoadEventMap extends EventMapEvent {}
