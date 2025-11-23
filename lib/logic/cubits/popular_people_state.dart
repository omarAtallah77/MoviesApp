import 'package:equatable/equatable.dart';

import '../../data/models/person_model.dart';

abstract class PeopleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PopularPeopleInitial extends PeopleState {}

class PopularPeopleLoading extends PeopleState {}

class PopularPeopleSuccess extends PeopleState {
  final List<PersonModel> people;
  final bool hasReachedMax;
  final int page;
  final List<String> images;

  PopularPeopleSuccess({
    required this.people,
    required this.page,
    this.hasReachedMax = false,
    this.images = const [],
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

class PopularPeopleFailure extends PeopleState {
  final String message;
  PopularPeopleFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class PersonDetailsInitial extends PeopleState {}

class PersonDetailsLoading extends PeopleState {}

class PersonDetailsSuccess extends PeopleState {
  final Map<String, dynamic> person;
  final List<String> images;

  PersonDetailsSuccess({required this.person, required this.images});

  @override
  List<Object?> get props => [person, images];
}

class PersonDetailsFailure extends PeopleState {
  final String message;
  PersonDetailsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
