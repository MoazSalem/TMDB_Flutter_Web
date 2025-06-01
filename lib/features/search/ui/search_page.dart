import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/core/shared_widgets/poster_list_widget.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';
import 'package:tmdb_web/features/search/ui/widgets/searchbar_widget.dart';

class SearchPage extends StatefulWidget {
  final bool isMovie;

  const SearchPage({super.key, required this.isMovie});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MediaQuery.sizeOf(context);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(isSearch: false),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.h),
              child: Column(
                children: [
                  SearchbarWidget(
                    searchController: searchController,
                    onChanged: (query) => context.read<SearchCubit>().search(
                      query: query,
                      type: widget.isMovie ? 0 : 1,
                    ),
                  ),
                  state is SearchLoading
                      ? SizedBox(
                          height: 40.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : state is SearchLoaded
                      ? state.searchResult.isEmpty
                            ? SizedBox(
                                height: 40.h,
                                child: Center(child: const Text("No Results")),
                              )
                            : PosterListWidget(list: state.searchResult)
                      : SizedBox(
                          height: 40.h,
                          child: Center(
                            child: const Text("Start typing to search"),
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
