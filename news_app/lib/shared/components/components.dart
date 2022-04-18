import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Bloc/NewsStates.dart';
import '../../Modules/WebViewNews/WebViewScreen.dart';

Widget buildLoginBtn({
  String text = 'Login',
  double width = double.infinity,
  required Null Function() function,
}) {
  return MaterialButton(
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    onPressed: function,
    color: Colors.blue,
    minWidth: width,
    textColor: Colors.white,
    padding: const EdgeInsets.all(10),
  );
}

//////////////////////////////////////////////////
Widget buildTextFormField({
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  required TextInputType inputType,
  FormFieldValidator<String>? validatorFun,
  Null Function()? suffixFun,
  Null Function()? onTapFun,
  Null Function(String)? onChangedFun,
  Null Function(String)? onSubmittedFun,
  IconData? suffix,
  bool obscureText = false,
}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(
        icon: Icon(suffix),
        onPressed: suffixFun,
      ),
      border: const OutlineInputBorder(),
    ),
    keyboardType: inputType,
    validator: validatorFun,
    obscureText: obscureText,
    onTap: onTapFun,
    onChanged: onChangedFun,
    onFieldSubmitted: onSubmittedFun,
    style: const TextStyle(fontFamily: 'Arial'),
  );
}

//////////////////////////////////////////////////

Widget buildNewsListItem(imageUrl, title, date, url, context) {
  return InkWell(
    onTap: () {
      navigateNextScreen(context, WebViewScreen(url));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(imageUrl ??
                      'https://icon-library.com/images/no-picture-available-icon/no-picture-available-icon-1.jpg'),
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${title ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '${date ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildListSeparator() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    );
Widget buildNewsScreen(List<dynamic> list, NewsStates state) =>
    ConditionalBuilder(
      condition: state is! LoadingNewsState,
      builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildNewsListItem(
              list[index]['urlToImage'],
              list[index]['title'],
              list[index]['publishedAt'],
              list[index]['url'],
              context),
          separatorBuilder: (context, index) => buildListSeparator(),
          itemCount: list.length),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );

void navigateNextScreen(context, nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

void navigateNextScreenAndFinish(context, nextScreen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => nextScreen), (route) => false);
}

void showToast(String msg, Color backgroundColor,
    {Toast toastLength = Toast.LENGTH_SHORT,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int timeInSecForIosWeb = 2,
    Color textColor = Colors.white,
    double fontSize = 15}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize);
}

Future<void> showMyDialog(context, Null Function() yesFunction) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                'Are you sure to logout ?',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: yesFunction,
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
