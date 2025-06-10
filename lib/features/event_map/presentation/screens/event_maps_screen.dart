import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/map_style_loader.dart';
import '../../domain/entities/event.dart';
import '../bloc/event_map_bloc.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/event_bottom_sheet.dart';

class EventMapScreen extends StatefulWidget {
  const EventMapScreen({super.key});

  @override
  State<EventMapScreen> createState() => _EventMapScreenState();
}

class _EventMapScreenState extends State<EventMapScreen>
    with TickerProviderStateMixin {
  final LatLng center = const LatLng(37.7749, -122.4194);
  final Random _random = Random();
  Set<Marker> markers = {};
  GoogleMapController? _mapController;

  bool _isMapReady = false;
  double _mapOpacity = 0.0;

  late final AnimationController _navController;
  late final Animation<Offset> _navOffset;
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _navController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _navOffset = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _navController, curve: Curves.easeOut));

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _navController.forward();
  }

  @override
  void dispose() {
    _navController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void animateMarkers(List<Event> events) async {
    for (int i = 0; i < events.length; i++) {
      final event = events[i];
      final double latOffset = _random.nextDouble() * 0.1 - 0.05;
      final double lngOffset = _random.nextDouble() * 0.1 - 0.05;
      final marker = Marker(
        markerId: MarkerId(event.name),
        position:
            LatLng(center.latitude + latOffset, center.longitude + lngOffset),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: event.name),
      );
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => markers.add(marker));
    }
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    final style = await loadMapStyle(context);
    await _mapController?.setMapStyle(style);

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _isMapReady = true;
      _mapOpacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<EventMapBloc, EventMapState>(
        listener: (context, state) {
          if (state is EventMapLoaded) animateMarkers(state.events);
        },
        builder: (context, state) {
          final List<Event> events =
              state is EventMapLoaded ? state.events : [];

          return Stack(
            children: [
              AnimatedOpacity(
                opacity: _mapOpacity,
                duration: const Duration(seconds: 1),
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: center, zoom: 13),
                  markers: markers,
                  zoomControlsEnabled: false,
                  mapType: MapType.normal,
                ),
              ),
              if (!_isMapReady)
                const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNav(
                    onFireTap: () => showCustomBottomSheet(context, events),
                    pulseAnimation: _pulseAnimation,
                    navOffset: _navOffset,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
