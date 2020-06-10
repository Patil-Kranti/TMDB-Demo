import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SearchMovies extends StatefulWidget {
  final String searchString;

  const SearchMovies({Key key, @required this.searchString}) : super(key: key);
  @override
  _SearchMoviesState createState() => _SearchMoviesState(searchString);
}

class _SearchMoviesState extends State<SearchMovies> {
  String searchString;
  _SearchMoviesState(this.searchString);
  bool isSearchCalled = false;
  final _searchTextController = TextEditingController();
  List<Search> menuItems;
  List<Search> menuItems2 = [];
  final _scaffoldState = GlobalKey<ScaffoldState>();
  Size deviceSize;
  BuildContext _context;
  //menuStack
  Widget menuStack(BuildContext context, Search menu) => InkWell(
        onTap: () {
          Toast.show(menu.title, context);
        },
        splashColor: Colors.orange,
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 2.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              menuImage(menu),
              menuColor(),
              menuData(menu),
            ],
          ),
        ),
      );

  //stack 1/3
  Widget menuImage(Search menu) => menu.image == null
      ? Image.asset("assets/images/logo.png")
      : Image.network(
          menu.image,
          fit: BoxFit.cover,
        );

  //stack 2/3
  Widget menuColor() => new Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 5.0,
          ),
        ]),
      );

  //stack 3/3
  Widget menuData(Search menu) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            menu.title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            menu.subtitle.toString(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      );

  //appbar
  Widget appBar() => SliverAppBar(
        actions: <Widget>[],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        pinned: true,
        elevation: 10.0,
        forceElevated: true,
        expandedHeight: 60.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.blueGrey.shade800,
              Colors.black87,
            ])),
          ),
          title: Row(
            children: <Widget>[
              FlutterLogo(
                colors: Colors.yellow,
                textColor: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text('Search Moive')
            ],
          ),
        ),
      );

  //bodygrid
  Widget bodyGrid(List<Search> menu) => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? 2
                  : 3,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return menuStack(context, menu[index]);
        }, childCount: menu.length),
      );

  Widget homeScaffold(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.blueGrey[200],
          key: _scaffoldState,
          body: bodySliverList(),
        )),
      );

  Widget bodySliverList() {
    // MovieViewModel _movieVM = new MovieViewModel();

    return FutureBuilder<List<Search>>(
        future: getSearchData(searchString),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: <Widget>[
                    appBar(),
                    bodyGrid(snapshot.data),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    deviceSize = MediaQuery.of(context).size;
    return homeScaffold(context);
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

  Future<List<Search>> getSearchData(String searchString) async {
    var data, datavalue;
    var pageNumber = 1, totalPages;
    var uri = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=6f4182488ec892208939e20eb41b6b72&language=en-US&query=$searchString"); //
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
        menuItems2.add(Search(
          title: "Title: ${datavalue[i]["title"]}",
          id: datavalue[i]["id"],
          subtitle: "Ratings: ${datavalue[i]["vote_average"]}",
          // icon: AssetImage("assets/images/updateproject.png"),
          image: datavalue[i]["poster_path"] == null
              ? "null"
              : "https://image.tmdb.org/t/p/w600_and_h900_bestv2/${datavalue[i]["poster_path"]}",
        ));
      }
    });
    return menuItems2;
  }

  // getMenuItems() {
  //   return getSearchData();
  // }
}

class Search {
  var title, subtitle;
  var id;
  ImageProvider icon;
  String image;
  BuildContext context;

  Search({
    this.title,
    // this.icon,
    this.image,
    this.id,
    this.subtitle,
    this.context,
  });
}
