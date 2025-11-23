import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/reposatories/person_repository.dart';
import '../../logic/cubits/person_details_cubit.dart';
import '../../logic/cubits/popular_people_state.dart';

class PersonDetailsScreen extends StatelessWidget {
  final int personId;

  const PersonDetailsScreen({super.key, required this.personId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PersonDetailsCubit(context.read<PersonRepository>())
            ..fetchPersonDetails(personId),
      child: BlocBuilder<PersonDetailsCubit, PeopleState>(
        builder: (context, state) {
          if (state is PersonDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonDetailsFailure) {
            return Center(child: Text(state.message));
          } else if (state is PersonDetailsSuccess) {
            final images = state.images;
            final person = state.person;

            return Column(
              children: [
                Text(
                  person['name'] ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final path = images[index];
                      final url = 'https://image.tmdb.org/t/p/w200$path';
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/imageViewer',
                            arguments:
                                'https://image.tmdb.org/t/p/original$path',
                          );
                        },
                        child: Image.network(url, fit: BoxFit.cover),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
