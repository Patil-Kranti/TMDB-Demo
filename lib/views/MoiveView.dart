import 'package:flutter/material.dart';
import 'package:movie_review/model/movieModel.dart';
import 'package:movie_review/views/SearchMovies.dart';
import 'package:movie_review/views/searchBar.dart';
import 'package:toast/toast.dart';

class MovieView extends StatefulWidget {
  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  Size deviceSize;
  BuildContext _context;
  //menuStack
  Widget menuStack(BuildContext context, Menu menu) => InkWell(
        onTap: () {
          Toast.show(menu.title, context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ProjectMenu(
          //             projectName: menu.title, projectID: menu.id)));
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
  Widget menuImage(Menu menu) => Image.network(
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
  Widget menuData(Menu menu) => Column(
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
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Searchbar()));
                },
              )),
        ],
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
              Text('Moive List')
            ],
          ),
        ),
      );

  //bodygrid
  Widget bodyGrid(List<Menu> menu) => SliverGrid(
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
                body: bodySliverList())),
      );

  Widget bodySliverList() {
    MovieViewModel _movieVM = new MovieViewModel();

    return FutureBuilder<List<Menu>>(
        future: _movieVM.getdata(),
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

  Widget header() => Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.cyan.shade600, Colors.blue.shade900])),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage("assets/images/logo.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/logo.png'),
              )
            ],
          ),
        ),
      );

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
}
