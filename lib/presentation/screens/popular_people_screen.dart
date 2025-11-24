import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/presentation/screens/person_details_screen.dart';

import '../../logic/cubits/popular_people_cubit.dart';
import '../../logic/cubits/popular_people_state.dart';
import '../widgets/personCard.dart';

class PopularPeopleScreen extends StatefulWidget {
  @override
  _PopularPeopleScreenState createState() => _PopularPeopleScreenState();
}

class _PopularPeopleScreenState extends State<PopularPeopleScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PopularPeopleCubit>().fetchInitial();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PopularPeopleCubit>().fetchMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final max = _scrollController.position.maxScrollExtent;
    final pos = _scrollController.position.pixels;
    return pos >= (max * 0.9); // when the user reaches 90% of list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular People')),
      body: BlocBuilder<PopularPeopleCubit, PeopleState>(
        builder: (context, state) {
          if (state is PopularPeopleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PopularPeopleFailure) {
            return Center(child: Text(state.message));
          } else if (state is PopularPeopleSuccess) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.people.length
                  : state.people.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.people.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final person = state.people[index];

                return PersonTile(
                  person: person,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PersonDetailsScreen(personId: person.id);
                        },
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
