import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weather_provider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1.0,
            blurRadius: 15.0,
            offset: const Offset(8.0, 6.0),
          ),
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        controller: _textController,
        style: const TextStyle(
          color: Colors.black,
        ),
        maxLines: 1,
        onSubmitted: (value) {
          setState(() {
            _textController.text.isEmpty
                ? _validate = true
                : Provider.of<WeatherProvider>(context, listen: false)
                    .searchWeatherData(location: value);
          });
        },
        decoration: InputDecoration(
            hintText: 'Search Location',
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            errorText: _validate ? null : null,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            icon: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            contentPadding: const EdgeInsets.only(
              left: 0.0,
              bottom: 11.0,
              top: 11.0,
              right: 15.0,
            )),
      ),
    );
  }
}
