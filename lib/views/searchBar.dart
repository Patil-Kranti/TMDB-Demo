import 'package:flutter/material.dart';
import 'package:movie_review/views/SearchMovies.dart';

class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final _incomeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Movies"),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: TextFormField(
              controller: _incomeTextController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                filled: true,
                suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      var searchString =
                          _incomeTextController.text.toString().trim();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchMovies(
                                    searchString: searchString,
                                  )));
                    }),
                hintText: 'Search Movies',
                labelText: 'Search Movies',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
