// import 'dart:io';
// import 'dart:typed_data';

// import 'package:dio/dio.dart';
// import 'package:fpdart/fpdart.dart';

// import '/data/datasources/auth/login_data_sources.dart';
// import '/domain/failures/network/network_failure.dart';
// import '/domain/repositories/local/local_storage_base_api_service.dart';
// import 'dio_config.dart';
// import 'dio_network_repository.dart';

// // Example model classes
// class User {
//   final String id;
//   final String name;
//   final String email;
//   final String? avatar;

//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.avatar,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       avatar: json['avatar'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//       if (avatar != null) 'avatar': avatar,
//     };
//   }
// }

// class Product {
//   final String id;
//   final String name;
//   final double price;

//   Product({required this.id, required this.name, required this.price});

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       price: json['price'].toDouble(),
//     );
//   }
// }

// // Example usage of the Dio Network Repository
// class DioUsageExamples {
//   late final DioNetworkRepository _networkRepository;
//   late final LoginDataSources _loginDataSources;
//   late final LocalStorageRepository _localStorageRepository;

//   DioUsageExamples({
//     required LoginDataSources loginDataSources,
//     required LocalStorageRepository localStorageRepository,
//   }) {
//     _loginDataSources = loginDataSources;
//     _localStorageRepository = localStorageRepository;
//     _networkRepository = DioNetworkRepository(
//       _loginDataSources,
//       _localStorageRepository,
//     );
//   }

//   // Example 1: Basic GET request
//   Future<void> exampleGetRequest() async {
//     final result = await _networkRepository.get<Map<String, dynamic>>(
//       url: '/api/users/profile',
//       headers: {'Custom-Header': 'value'},
//     );

//     result.fold(
//       (failure) => print('Error: ${failure.error}'),
//       (data) => print('User profile: $data'),
//     );
//   }

//   // Example 2: POST request with JSON body
//   Future<void> examplePostRequest() async {
//     final userData = {
//       'name': 'John Doe',
//       'email': 'john@example.com',
//       'age': 30,
//     };

//     final result = await _networkRepository.post<Map<String, dynamic>>(
//       url: '/api/users',
//       body: userData,
//     );

//     result.fold(
//       (failure) => print('Error: ${failure.error}'),
//       (data) => print('Created user: $data'),
//     );
//   }

//   // Example 3: PUT request with form data
//   Future<void> examplePutWithFormData() async {
//     final formData = {
//       'name': 'Updated Name',
//       'bio': 'Updated bio',
//       'avatar': File('/path/to/avatar.jpg'),
//     };

//     final result = await _networkRepository.put<Map<String, dynamic>>(
//       url: '/api/users/profile',
//       body: formData,
//       isFormData: true,
//     );

//     result.fold(
//       (failure) => print('Error: ${failure.error}'),
//       (data) => print('Updated profile: $data'),
//     );
//   }

//   // Example 4: Pagination
//   Future<void> examplePagination() async {
//     final result = await _networkRepository.getPaginated<User>(
//       url: '/api/users',
//       page: 1,
//       limit: 10,
//       fromJson: User.fromJson,
//       queryParams: {'status': 'active'},
//     );

//     result.fold((failure) => print('Error: ${failure.error}'), (
//       paginatedResponse,
//     ) {
//       print('Current page: ${paginatedResponse.currentPage}');
//       print('Total pages: ${paginatedResponse.totalPages}');
//       print('Total items: ${paginatedResponse.totalItems}');
//       print('Has next page: ${paginatedResponse.hasNextPage}');
//       print('Users: ${paginatedResponse.data}');
//     });
//   }

//   // Example 5: File upload with progress
//   Future<void> exampleFileUpload() async {
//     final file = File('/path/to/document.pdf');

//     final result = await _networkRepository.uploadFile<Map<String, dynamic>>(
//       url: '/api/documents/upload',
//       file: file,
//       fieldName: 'document',
//       additionalData: {
//         'title': 'Important Document',
//         'category': 'pdf',
//         'description': 'This is an important document',
//       },
//       onProgress: (sent, total) {
//         final progress = (sent / total * 100).toStringAsFixed(2);
//         print('Upload progress: $progress%');
//       },
//     );

//     result.fold(
//       (failure) => print('Upload failed: ${failure.error}'),
//       (data) => print('Upload successful: $data'),
//     );
//   }

//   // Example 6: Multiple files upload
//   Future<void> exampleMultipleFilesUpload() async {
//     final files = [
//       File('/path/to/image1.jpg'),
//       File('/path/to/image2.jpg'),
//       File('/path/to/image3.jpg'),
//     ];

//     final result = await _networkRepository
//         .uploadMultipleFiles<Map<String, dynamic>>(
//           url: '/api/gallery/upload',
//           files: files,
//           fieldName: 'images',
//           additionalData: {
//             'album_name': 'Vacation Photos',
//             'description': 'Photos from my vacation',
//           },
//           onProgress: (sent, total) {
//             final progress = (sent / total * 100).toStringAsFixed(2);
//             print('Upload progress: $progress%');
//           },
//         );

//     result.fold(
//       (failure) => print('Upload failed: ${failure.error}'),
//       (data) => print('Upload successful: $data'),
//     );
//   }

//   // Example 7: File download with progress
//   Future<void> exampleFileDownload() async {
//     final result = await _networkRepository.downloadFile(
//       url: '/api/documents/download/123',
//       savePath: '/path/to/save/document.pdf',
//       onProgress: (received, total) {
//         final progress = (received / total * 100).toStringAsFixed(2);
//         print('Download progress: $progress%');
//       },
//     );

//     result.fold(
//       (failure) => print('Download failed: ${failure.error}'),
//       (file) => print('Download completed: ${file.path}'),
//     );
//   }

//   // Example 8: Stream download
//   Future<void> exampleStreamDownload() async {
//     final result = await _networkRepository.downloadStream(
//       url: '/api/documents/stream/123',
//     );

//     result.fold((failure) => print('Stream failed: ${failure.error}'), (
//       stream,
//     ) {
//       // Process the stream
//       stream.listen(
//         (chunk) => print('Received chunk: ${chunk.length} bytes'),
//         onDone: () => print('Stream completed'),
//         onError: (error) => print('Stream error: $error'),
//       );
//     });
//   }

//   // Example 9: Using FormDataHelper directly
//   Future<void> exampleFormDataHelper() async {
//     // Create form data with files
//     final formData = await FormDataHelper.createFormData(
//       data: {
//         'title': 'My Post',
//         'content': 'This is the content',
//         'tags': 'flutter,dart,network',
//       },
//       files: [File('/path/to/image1.jpg'), File('/path/to/image2.jpg')],
//       fileFieldName: 'images',
//     );

//     // Create form data with bytes
//     final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
//     final formDataWithBytes = FormDataHelper.createFormDataWithBytes(
//       data: {'name': 'Test File'},
//       fileBytes: {'file': bytes},
//       fileNames: {'file': 'test.bin'},
//     );
//   }

//   // Example 10: Using PaginationHelper directly
//   Future<void> examplePaginationHelper() async {
//     // Create pagination parameters
//     final params = PaginationHelper.createPaginationParams(
//       page: 1,
//       limit: 20,
//       sortBy: 'created_at',
//       sortOrder: 'desc',
//       additionalParams: {'status': 'active'},
//     );

//     // Parse paginated response
//     final responseData = {
//       'data': [
//         {'id': '1', 'name': 'Product 1', 'price': 10.99},
//         {'id': '2', 'name': 'Product 2', 'price': 20.99},
//       ],
//       'pagination': {
//         'currentPage': 1,
//         'totalPages': 5,
//         'totalItems': 100,
//         'hasNextPage': true,
//         'hasPreviousPage': false,
//       },
//     };

//     final paginatedResponse = PaginationHelper.parsePaginatedResponse<Product>(
//       responseData: responseData,
//       fromJson: Product.fromJson,
//     );

//     print('Products: ${paginatedResponse.data}');
//     print('Has more data: ${paginatedResponse.hasMoreData}');
//   }

//   // Example 11: Error handling
//   Future<void> exampleErrorHandling() async {
//     try {
//       final result = await _networkRepository.get<Map<String, dynamic>>(
//         url: '/api/nonexistent-endpoint',
//       );

//       result.fold((failure) {
//         switch (failure.error) {
//           case 'Unauthorized access':
//             print('User needs to login');
//             break;
//           case 'No internet connection':
//             print('Check internet connection');
//             break;
//           case 'Connection timeout':
//             print('Request timed out, try again');
//             break;
//           default:
//             print('Unknown error: ${failure.error}');
//         }
//       }, (data) => print('Success: $data'));
//     } catch (e) {
//       print('Unexpected error: $e');
//     }
//   }

//   // Example 12: Request cancellation
//   Future<void> exampleRequestCancellation() async {
//     // Start a long-running request
//     final future = _networkRepository.get<Map<String, dynamic>>(
//       url: '/api/slow-endpoint',
//     );

//     // Cancel after 5 seconds
//     Future.delayed(const Duration(seconds: 5), () {
//       _networkRepository.cancelRequests();
//       print('Requests cancelled');
//     });

//     try {
//       final result = await future;
//       result.fold(
//         (failure) => print('Error: ${failure.error}'),
//         (data) => print('Success: $data'),
//       );
//     } catch (e) {
//       print('Request was cancelled: $e');
//     }
//   }

//   // Example 13: Cache management
//   Future<void> exampleCacheManagement() async {
//     // Clear cache
//     _networkRepository.clearCache();

//     // Make a request that will be cached
//     final result = await _networkRepository.get<Map<String, dynamic>>(
//       url: '/api/user/profile', // This endpoint is cached by CacheInterceptor
//     );

//     result.fold(
//       (failure) => print('Error: ${failure.error}'),
//       (data) => print('Profile data: $data'),
//     );
//   }

//   // Example 14: Custom Dio configuration
//   Future<void> exampleCustomDioConfig() async {
//     final customDio = DioConfig.createDio(
//       loginDataSources: _loginDataSources,
//       localStorageRepository: _localStorageRepository,
//       baseUrl: 'https://api.example.com',
//       connectTimeout: const Duration(seconds: 60),
//       receiveTimeout: const Duration(seconds: 60),
//       sendTimeout: const Duration(seconds: 60),
//     );

//     // Use custom Dio instance
//     final response = await customDio.get('/api/custom-endpoint');
//     print('Custom response: ${response.data}');
//   }

//   // Example 15: Batch requests
//   Future<void> exampleBatchRequests() async {
//     final futures = [
//       _networkRepository.get<Map<String, dynamic>>(url: '/api/users/1'),
//       _networkRepository.get<Map<String, dynamic>>(url: '/api/users/2'),
//       _networkRepository.get<Map<String, dynamic>>(url: '/api/users/3'),
//     ];

//     final results = await Future.wait(futures);

//     for (int i = 0; i < results.length; i++) {
//       results[i].fold(
//         (failure) => print('User ${i + 1} error: ${failure.error}'),
//         (data) => print('User ${i + 1}: $data'),
//       );
//     }
//   }
// }

// // Example of how to use the repository in a service class
// class UserService {
//   final DioNetworkRepository _networkRepository;

//   UserService(this._networkRepository);

//   Future<Either<NetworkFailure, PaginatedResponse<User>>> getUsers({
//     int page = 1,
//     int limit = 10,
//   }) async {
//     return await _networkRepository.getPaginated<User>(
//       url: '/api/users',
//       page: page,
//       limit: limit,
//       fromJson: User.fromJson,
//     );
//   }

//   Future<Either<NetworkFailure, User>> createUser(User user) async {
//     return await _networkRepository.post<User>(
//       url: '/api/users',
//       body: user.toJson(),
//     );
//   }

//   Future<Either<NetworkFailure, User>> updateUser(String id, User user) async {
//     return await _networkRepository.put<User>(
//       url: '/api/users/$id',
//       body: user.toJson(),
//     );
//   }

//   Future<Either<NetworkFailure, void>> deleteUser(String id) async {
//     return await _networkRepository.delete<void>(url: '/api/users/$id');
//   }
// }
