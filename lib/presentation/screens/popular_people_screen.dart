import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../logic/cubits/popular_people_cubit.dart';
import '../../logic/cubits/popular_people_state.dart';
import '../screens/person_details_screen.dart';
import '../widgets/personCard.dart';

class PopularPeopleScreen extends HookWidget {
  const PopularPeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scroll controller created without StatefulWidget
    final scrollController = useScrollController();

    // Run once → fetch initial people
    useEffect(() {
      context.read<PopularPeopleCubit>().fetchInitial();

      scrollController.addListener(() {
        final max = scrollController.position.maxScrollExtent;
        final pos = scrollController.position.pixels;

        if (pos >= max * 0.9) {
          context.read<PopularPeopleCubit>().fetchMore();
        }
      });

      return null; // cleanup is optional here
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Popular People')),
      body: BlocBuilder<PopularPeopleCubit, PeopleState>(
        builder: (context, state) {
          if (state is PopularPeopleLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PopularPeopleFailure) {
            return Center(child: Text(state.message));
          }

          if (state is PopularPeopleSuccess) {
            return GridView.builder(
              addAutomaticKeepAlives: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 6,
                childAspectRatio: 0.65,
              ),
              controller: scrollController,
              itemCount: state.hasReachedMax
                  ? state.people.length
                  : state.people.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.people.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final person = state.people[index];

                return PersonTile(
                  person: person,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PersonDetailsScreen(personId: person.id),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
