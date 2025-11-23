import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/logic/cubits/popular_people_state.dart';

import '../../data/reposatories/person_repository.dart';

class PersonDetailsCubit extends Cubit<PeopleState> {
  final PersonRepository repo;

  PersonDetailsCubit(this.repo) : super(PersonDetailsInitial());

  Future<void> fetchPersonDetails(int id) async {
    emit(PersonDetailsLoading());
    try {
      final details = await repo.getPersonDetails(id);
      final images = await repo.getPersonImages(id);
      emit(PersonDetailsSuccess(person: details, images: images));
    } catch (e) {
      emit(PersonDetailsFailure(e.toString()));
    }
  }
}
