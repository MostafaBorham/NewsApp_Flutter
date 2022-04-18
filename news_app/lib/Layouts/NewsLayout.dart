// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/NewsCubit.dart';
import '../Bloc/NewsStates.dart';
import '../Modules/NewsSearchScreen/SearchScreen.dart';
import '../shared/components/components.dart';

class NewsLayout extends StatelessWidget {
  NewsCubit? cubit;

  NewsLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = NewsCubit.getInstance(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    navigateNextScreen(context, SearchScreen());
                    cubit!.getAllFilteredNews('*', GetAllFilteredNewsState());
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.brightness_medium,
                  ),
                  onPressed: () {
                    cubit!.changeAppMode();
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.business_sharp,
                  ),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.sports,
                  ),
                  label: 'Sports',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.science,
                  ),
                  label: 'Sciences',
                ),
              ],
              currentIndex: cubit!.currentIndex,
              onTap: (index) {
                cubit!.changeBottomNavBarIndex(index);
              },
            ),
            body: cubit!.NewsScreens[cubit!.currentIndex],
          );
        });
  }
}
