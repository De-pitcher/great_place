import 'package:flutter/material.dart';
import 'package:location/location.dart' as ltlg;

import '../screens/map_screen.dart';
import '../models/place.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  PlaceLocation? placeLocation;

  @override
  void initState() {
    // Initial the location
    Future.delayed(
      Duration.zero,
      () => _getUserLocation(),
    );
    super.initState();
  }

  void _showPreview(PlaceLocation selectedLocation) {
    setState(() {
      _previewImageUrl =
          LocationHelper.getStaticImageWithMarker(selectedLocation);
    });
  }

  Future<void> _getUserLocation() async {
    final locData = await ltlg.Location().getLocation();
    placeLocation = PlaceLocation(
      latitude: locData.latitude!,
      longitude: locData.longitude!,
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      _showPreview(placeLocation!);
      final currentLocData = await LocationHelper.getAddress(placeLocation!);
      widget.onSelectPlace(
        placeLocation!.latitude,
        placeLocation!.longitude,
        currentLocData.first.addressLine,
      );
    } catch (_) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<PlaceLocation?>(
      MaterialPageRoute(
        builder: (_) => MapScreen(
          isSelecting: true,
          initialLocation: placeLocation!,
        ),
      ),
    );
    if (selectedLocation == null) return;
    _showPreview(selectedLocation);
    widget.onSelectPlace(
      selectedLocation.latitude,
      selectedLocation.longitude,
      selectedLocation.address,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? const Text('No Location Choosen')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
            ),
            ElevatedButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            ),
          ],
        )
      ],
    );
  }
}
