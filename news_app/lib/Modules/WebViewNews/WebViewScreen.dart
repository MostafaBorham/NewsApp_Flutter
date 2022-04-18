// ignore_for_file: must_be_immutable, file_names
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Bloc/NewsCubit.dart';

class WebViewScreen extends StatelessWidget {
  NewsCubit? cubit;
  String url;

  WebViewScreen(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cubit = NewsCubit.getInstance(context);
    return Scaffold(
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
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
