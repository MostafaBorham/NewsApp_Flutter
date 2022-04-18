// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/NewsCubit.dart';
import '../../Bloc/NewsStates.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class SciencesScreen extends StatelessWidget {
  const SciencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) => buildNewsScreen(sciencesNews, state));
}
