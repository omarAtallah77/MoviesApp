import 'package:equatable/equatable.dart';

import '../../data/models/person_model.dart';

abstract class PopularPeopleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularPeopleInitial extends PopularPeopleState {}

class PopularPeopleLoading extends PopularPeopleState {}

class PopularPeopleSuccess extends PopularPeopleState {
  final List<PersonModel> people;
  final bool hasReachedMax;
  final int page;

  PopularPeopleSuccess({
    required this.people,
    required this.page,
    this.hasReachedMax = false,
  });

  PopularPeopleSuccess copyWith({
    List<PersonModel>? people,
    bool? hasReachedMax,
    int? page,
  }) {
    return PopularPeopleSuccess(
      people: people ?? this.people,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [people, hasReachedMax, page];
}

class PopularPeopleFailure extends PopularPeopleState {
  final String message;
  PopularPeopleFailure(this.message);

  @override
  List<Object?> get props => [message];
}
