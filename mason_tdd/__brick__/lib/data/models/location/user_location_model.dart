// class UserLocationModel {
//   final double latitude;
//   final double longitude;
//   final double? altitude;
//   final double accuracy;
//   final double? heading;
//   final double? speed;
//   final DateTime timestamp;

//   const UserLocationModel({
//     required this.latitude,
//     required this.longitude,
//     this.altitude,
//     required this.accuracy,
//     this.heading,
//     this.speed,
//     required this.timestamp,
//   });

//   factory UserLocationModel.empty() => UserLocationModel(
//     latitude: 0.0,
//     longitude: 0.0,
//     accuracy: 0.0,
//     timestamp: DateTime.now(),
//   );

//   UserLocationModel copyWith({
//     double? latitude,
//     double? longitude,
//     double? altitude,
//     double? accuracy,
//     double? heading,
//     double? speed,
//     DateTime? timestamp,
//   }) {
//     return UserLocationModel(
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//       altitude: altitude ?? this.altitude,
//       accuracy: accuracy ?? this.accuracy,
//       heading: heading ?? this.heading,
//       speed: speed ?? this.speed,
//       timestamp: timestamp ?? this.timestamp,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'latitude': latitude,
//       'longitude': longitude,
//       'altitude': altitude,
//       'accuracy': accuracy,
//       'heading': heading,
//       'speed': speed,
//       'timestamp': timestamp.toIso8601String(),
//     };
//   }

//   factory UserLocationModel.fromJson(Map<String, dynamic> json) {
//     return UserLocationModel(
//       latitude: (json['latitude'] as num).toDouble(),
//       longitude: (json['longitude'] as num).toDouble(),
//       altitude: json['altitude'] != null
//           ? (json['altitude'] as num).toDouble()
//           : null,
//       accuracy: (json['accuracy'] as num).toDouble(),
//       heading: json['heading'] != null
//           ? (json['heading'] as num).toDouble()
//           : null,
//       speed: json['speed'] != null ? (json['speed'] as num).toDouble() : null,
//       timestamp: DateTime.parse(json['timestamp'] as String),
//     );
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserLocationModel &&
//           runtimeType == other.runtimeType &&
//           latitude == other.latitude &&
//           longitude == other.longitude &&
//           altitude == other.altitude &&
//           accuracy == other.accuracy &&
//           heading == other.heading &&
//           speed == other.speed &&
//           timestamp == other.timestamp;

//   @override
//   int get hashCode =>
//       latitude.hashCode ^
//       longitude.hashCode ^
//       altitude.hashCode ^
//       accuracy.hashCode ^
//       heading.hashCode ^
//       speed.hashCode ^
//       timestamp.hashCode;

//   @override
//   String toString() {
//     return 'UserLocationModel(lat: $latitude, lng: $longitude, accuracy: $accuracy, timestamp: $timestamp)';
//   }
// }
