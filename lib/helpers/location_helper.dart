import 'package:flutter_geocoder/geocoder.dart';
import 'package:mapbox_search/colors/color.dart';
import 'package:mapbox_search/mapbox_search.dart';

import '../models/place.dart';
import '../utils/api_key.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=400x400&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static StaticImage staticImage = StaticImage(apiKey: STATIC_MAP_API_KEY);

  static String getStaticImageWithMarker(PlaceLocation location) {
    return staticImage.getStaticUrlWithMarker(
      center: Location(lat: location.latitude, lng: location.longitude),
      marker: MapBoxMarker(
          markerColor: const RgbColor(0, 0, 0),
          markerLetter: 'p',
          markerSize: MarkerSize.LARGE),
      height: 300,
      width: 600,
      zoomLevel: 14,
      style: MapBoxStyle.Outdoors,
      render2x: true,
    );
  }

  static var reverseGeoCoding = ReverseGeoCoding(
    apiKey: STATIC_MAP_API_KEY,
    limit: 5,
  );

  static Future<List<Address>> getAddress(PlaceLocation placeLocation) async {
    final coordinates =
        Coordinates(placeLocation.latitude, placeLocation.latitude);
    return Geocoder.local.findAddressesFromCoordinates(coordinates);
  }

  static Future<List<MapBoxPlace>?> getPlaces(PlaceLocation location) {
    return reverseGeoCoding.getAddress(
      Location(
        lat: location.latitude,
        lng: location.longitude,
      ),
    );
  }
}
