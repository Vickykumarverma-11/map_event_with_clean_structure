import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String name;
  final DateTime time;

  const Event({required this.name, required this.time});

  @override
  List<Object?> get props => [name, time];
}
