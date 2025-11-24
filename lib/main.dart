import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/dio_client.dart';
import 'data/data_sources/tmdp_remote_data_source.dart';
import 'data/reposatories/person_repository.dart';
import 'logic/cubits/person_details_cubit.dart';
import 'logic/cubits/popular_people_cubit.dart';
import 'presentation/screens/person_details_screen.dart';
import 'presentation/screens/popular_people_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Dio client and repository
    final dioClient = DioClient();
    final remote = TMDBRemoteDataSource(dioClient);
    final repo = PersonRepository(remote);

    return MultiRepositoryProvider(
      providers: [RepositoryProvider<PersonRepository>.value(value: repo)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PopularPeopleCubit(context.read<PersonRepository>())
                  ..fetchInitial(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: '/',
          routes: {
            '/': (context) => PopularPeopleScreen(),
            '/personDetails': (context) {
              final personId =
                  ModalRoute.of(context)!.settings.arguments as int;
              return BlocProvider<PersonDetailsCubit>(
                create: (context) =>
                    PersonDetailsCubit(context.read<PersonRepository>())
                      ..fetchPersonDetails(personId),
                child: PersonDetailsScreen(personId: personId),
              );
            },
          },
        ),
      ),
    );
  }
}
