import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tmdb_web/core/shared_widgets/custom_app_bar.dart';
import 'package:tmdb_web/core/shared_widgets/poster_list_widget.dart';
import 'package:tmdb_web/features/search/logic/search_cubit.dart';

class SearchPage extends StatefulWidget {
  final bool movie;

  const SearchPage({super.key, required this.movie});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late double width;
  final ScrollController scrollController = ScrollController();
  final TextEditingController moviesSearch = TextEditingController();
  final TextEditingController tvSearch = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.sizeOf(context).width;
  }

  @override
  void dispose() {
    scrollController.dispose();
    moviesSearch.dispose();
    tvSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: CustomAppBar(isSearch: false),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            cacheExtent: 3500,
            shrinkWrap: true,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5.w),
                  child: TextFormField(
                    controller: widget.movie ? moviesSearch : tvSearch,
                    onChanged: (query) {
                      context.read<SearchCubit>().search(
                        query: query,
                        type: widget.movie ? 0 : 1,
                      );
                    },
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff8fcea2)),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff09b5e1)),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      hintText: "Search",
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                ),
              ),
              state is SearchLoading
                  ? SizedBox(
                      height: 400,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : state is SearchLoaded
                  ? state.searchResult.isEmpty
                        ? const SizedBox(
                            height: 400,
                            child: Center(child: Text("No Results")),
                          )
                        : PosterListWidget(
                            list: state.searchResult,
                            scrollController: scrollController,
                          )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
