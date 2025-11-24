import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/reposatories/person_repository.dart';
import '../../logic/cubits/person_details_cubit.dart';
import '../../logic/cubits/popular_people_state.dart';
import '../widgets/component.dart';

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
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is PersonDetailsFailure) {
            return Scaffold(body: Center(child: Text(state.message)));
          }

          if (state is PersonDetailsSuccess) {
            final person = state.person;
            final images = state.images;

            final profileUrl = person.profilePath != null
                ? "https://image.tmdb.org/t/p/w300${person.profilePath}"
                : null;

            return Scaffold(
              appBar: AppBar(
                title: Text(person.name ?? "Person Details"),
                centerTitle: true,
              ),

              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: profileUrl != null
                            ? Image.network(
                                profileUrl,
                                width: 200,
                                height: 250,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 200,
                                height: 250,
                                color: Colors.grey[300],
                                child: const Icon(Icons.person, size: 80),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    custuizedtetfield(26, person.name),
                    custuizedtetfield(18, person.knownForDepartment),
                    const SizedBox(height: 20),
                    alignLeft("Biography"),
                    const SizedBox(height: 20),

                    Text(
                      person.biography ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 20),

                    alignLeft("Images"),

                    const SizedBox(height: 10),

                    SizedBox(
                      height: 160,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final path = images[index];
                          final url = "https://image.tmdb.org/t/p/w200$path";

                          return imageitem(context, url);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
