import '../data_sources/tmdp_remote_data_source.dart';
import '../models/person_model.dart';

class PersonRepository {
  final TMDBRemoteDataSource remote;

  PersonRepository(this.remote);

  Future<List<PersonModel>> getPopularPeople(int page) =>
      remote.fetchPopularPeople(page);

  Future<PersonModel> getPersonDetails(int id) => remote.getPersonDetails(id);

  Future<List<String>> getPersonImages(int id) => remote.getPersonImages(id);
}
