import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieViewModel {
  List<Menu> menuItems;
  List<Menu> menuItems2 = [];

  MovieViewModel({this.menuItems});
  Future<List<Menu>> getdata() async {
    var data, datavalue;
    var pageNumber = 1, totalPages;
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=6f4182488ec892208939e20eb41b6b72&language=en-US&page=$pageNumber"); //
    var request = new http.Request("GET", uri);

    print(request);

    var response = await request.send().timeout(const Duration(minutes: 2));
    if (response.statusCode == 200) print('Uploaded!');
    response.stream.transform(utf8.decoder).listen((value) async {
      data = jsonDecode(value);
      datavalue = data['results'];
      print(
        datavalue[0]["title"],
      );
      print(datavalue[0]["id"]);
      print(
        datavalue[0]["popularity"],
      );
      print(
          "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${datavalue[0]["poster_path"]}");
      print(data);
      for (var i = 0; i < datavalue.length; i++) {
        menuItems2.add(Menu(
          title: "Title: ${datavalue[i]["title"]}",
          id: datavalue[i]["id"],
          subtitle: "Ratings: ${datavalue[i]["vote_average"]}",
          // icon: AssetImage("assets/images/updateproject.png"),
          image:
              "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${datavalue[i]["poster_path"]}",
        ));
      }
    });
    return menuItems2;
  }

  getMenuItems() {
    return getdata();
  }
}

class Menu {
  var title, subtitle;
  var id;
  ImageProvider icon;
  String image;
  BuildContext context;

  Menu({
    this.title,
    // this.icon,
    this.image,
    this.id,
    this.subtitle,
    this.context,
  });
}
