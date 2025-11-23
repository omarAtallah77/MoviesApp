import '../../core/network/dio_client.dart';
import '../models/person_model.dart';

class TMDBRemoteDataSource {
  final DioClient client;
  TMDBRemoteDataSource(this.client);

  Future<List<PersonModel>> fetchPopularPeople(int page) async {
    final resp = await client.get(
      '/person/popular',
      queryParameters: {'page': page},
    );
    final results = resp.data['results'] as List;
    return results.map((e) => PersonModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getPersonDetails(int id) async {
    final resp = await client.get('/person/$id');
    return resp.data as Map<String, dynamic>;
  }

  Future<List<String>> getPersonImages(int id) async {
    final resp = await client.get('/person/$id/images');
    final profiles = resp.data['profiles'] as List;
    return profiles.map((p) => p['file_path'] as String).toList();
  }
}
