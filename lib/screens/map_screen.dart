import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      latitude: 6.119788,
      longitude: 6.7736584,
    ),
    this.isSelecting = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PlaceLocation? _pickedLocation;

  @override
  void initState() {
    _pickedLocation = widget.initialLocation;
    super.initState();
  }

  void _selectLocation(PickedData position) {
    setState(() {
      _pickedLocation = PlaceLocation(
        latitude: position.latLong.latitude,
        longitude: position.latLong.longitude,
        address: position.address,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(
                        _pickedLocation,
                      );
                    },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: OpenStreetMapSearchAndPick(
        center: _pickedLocation != null
            ? LatLong(
                _pickedLocation!.latitude,
                _pickedLocation!.longitude,
              )
            : LatLong(
                widget.initialLocation.latitude,
                widget.initialLocation.longitude,
              ),
        buttonColor: Colors.blue,
        buttonText: 'Set Current Location',
        onPicked: _selectLocation,
      ),
    );
  }
}
