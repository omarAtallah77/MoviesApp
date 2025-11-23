import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/reposatories/person_repository.dart';
import 'popular_people_state.dart';

class PopularPeopleCubit extends Cubit<PopularPeopleState> {
  final PersonRepository repo;
  static const int _firstPage = 1;

  PopularPeopleCubit(this.repo) : super(PopularPeopleInitial());

  Future<void> fetchInitial() async {
    emit(PopularPeopleLoading());
    try {
      final people = await repo.getPopularPeople(_firstPage);
      emit(
        PopularPeopleSuccess(
          people: people,
          page: _firstPage,
          hasReachedMax: people.isEmpty,
        ),
      );
    } catch (e) {
      emit(PopularPeopleFailure(e.toString()));
    }
  }

  Future<void> fetchMore() async {
    final stateNow = state;
    if (stateNow is PopularPeopleSuccess && !stateNow.hasReachedMax) {
      final nextPage = stateNow.page + 1;
      try {
        final more = await repo.getPopularPeople(nextPage);
        final hasReachedMax = more.isEmpty;
        emit(
          stateNow.copyWith(
            people: List.of(stateNow.people)..addAll(more),
            hasReachedMax: hasReachedMax,
            page: nextPage,
          ),
        );
      } catch (e) {
        emit(PopularPeopleFailure(e.toString()));
      }
    }
  }
}
