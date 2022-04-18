import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/BlocObserverTest.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/MySharedPreferences.dart';
import 'package:news_app/shared/styles/styles.dart';
import 'Bloc/NewsCubit.dart';
import 'Bloc/NewsStates.dart';
import 'Layouts/NewsLayout.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding
          .ensureInitialized(); //بتضمن ان الكود اللى بعدها يتنفذ اولا قبل تشغيل التطبيق
      await preInitRunApp();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              NewsCubit()..getCategoryNews('business', GetBusinessNewsState()),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              home: NewsLayout(),
              debugShowCheckedModeBanner: false,
              theme: MySharedPreferences.getBoolean(AppModeSharedPrefKey)!?appDarkTheme:appLightTheme,
            );
          }),
    ); //الماتريال اب هى اللى شايله كل سكرينات التطبيق بمعنى اصح هى تعتبر الاكتيفتيز ستاك وايضا من خلال نقدر نضع اعدادات وستايل للتطبيق كله
  }
}
