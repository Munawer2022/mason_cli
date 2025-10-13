// import 'package:geolocator/geolocator.dart';

// import '/data/datasources/location/user_location_data_source.dart';
// import '/data/models/location/user_location_model.dart';

// /// Simple Location Service for getting and storing user location
// /// Stores location data in UserLocationDataSource for easy access from cubits
// class LocationService {
//   final UserLocationDataSource _userLocationDataSource;

//   LocationService({required UserLocationDataSource userLocationDataSource})
//     : _userLocationDataSource = userLocationDataSource;

//   /// Get current location and store it in UserLocationDataSource
//   /// This is the main method to get location - it handles permissions and stores data
//   Future<void> getCurrentLocation() async {
//     try {
//       // Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         print('Location services are disabled');
//         return;
//       }

//       // Check permission
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           print('Location permission denied');
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         print('Location permission permanently denied');
//         return;
//       }

//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//         timeLimit: const Duration(seconds: 10),
//       );

//       // Create location model
//       UserLocationModel location = UserLocationModel(
//         latitude: position.latitude,
//         longitude: position.longitude,
//         altitude: position.altitude,
//         accuracy: position.accuracy,
//         heading: position.heading,
//         speed: position.speed,
//         timestamp: position.timestamp,
//       );

//       // Store in data source
//       _userLocationDataSource.updateLocation(location);

//       print('Location updated: ${location.latitude}, ${location.longitude}');
//     } catch (e) {
//       print('Error getting current location: $e');
//     }
//   }
// }
