// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/NewsCubit.dart';
import '../../Bloc/NewsStates.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SearchScreen extends StatelessWidget {
  NewsCubit? cubit;
  TextEditingController controller = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = NewsCubit.getInstance(context);
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'News App',
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.brightness_medium,
              ),
              onPressed: () {
                cubit!.changeAppMode();
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              buildTextFormField(
                  controller: controller,
                  label: 'Search',
                  prefix: Icons.search,
                  inputType: TextInputType.text,
                  onChangedFun: (value) {
                    cubit!.getAllFilteredNews(
                        value.isEmpty ? '*' : value, GetAllFilteredNewsState());
                  }),
              const SizedBox(
                height: 15,
              ),
              Expanded(child: buildNewsScreen(allFilteredNews, state))
            ],
          ),
        ),
      ),
    );
  }
}
