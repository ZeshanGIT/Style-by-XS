import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:style_by_xs/strings.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:style_by_xs/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Language lang = English();
  ScrollController scrollController = ScrollController();
  double toolbarOpacity = 0.0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    scrollController.addListener(() {
      double temp = scrollController.position.pixels / (56.0 + 25.0);
      setState(() {
        toolbarOpacity = temp <= 1 ? temp : 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          buildHomeBody(),
          buildAppBar(),
          buildMenuIcon(),
          buildStatusBar(),
          buildContinueBooking(context)
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.pink,
        ),
      ),
    );
  }

  Align buildContinueBooking(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
          bottom: Radius.zero,
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: Colors.purple,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Icon(Icons.photo, color: Colors.white, size: 50),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0),
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: Colors.white,
                    // gradient: LinearGradient(
                    //   begin: Alignment.bottomCenter,
                    //   end: Alignment.topCenter,
                    //   colors: [
                    //     Colors.white,
                    //     Colors.transparent,
                    //     Colors.transparent
                    //   ],
                    // ),
                  ),
                  child: Image.asset("assets/Graphic Design.png"),
                ),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AutoSizeText(
                    "Photography",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  AutoSizeText(
                    "Continue booking",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 16.0),
              IconButton(
                icon: Icon(Icons.navigate_next, color: Colors.white),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Align buildStatusBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 25,
        color: Colors.white,
      ),
    );
  }

  Align buildMenuIcon() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: 25.0 + 8.0, left: 8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
                tileMode: TileMode.repeated,
              ).createShader(bounds);
            },
            child: Icon(Icons.menu),
          ),
        ),
      ),
    );
  }

  Align buildAppBar() {
    return Align(
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: toolbarOpacity,
        child: Container(
          color: Colors.white,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text(
            lang.appBarTitle,
            style: TextStyle(fontSize: 24.0),
          ),
          height: 56 + 25.0,
        ),
      ),
    );
  }

  Widget buildHomeBody() {
    return LayoutBuilder(
        builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
      double height = boxConstraints.maxHeight;
      double width = boxConstraints.maxWidth;
      return SingleChildScrollView(
        controller: scrollController,
        child: Container(
          margin: EdgeInsets.only(top: 56.0 + 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildGreetings(height, width),
              SizedBox(height: height * 0.03),
              buildMyBookings(height, width),
              SizedBox(height: height * 0.03),
              Container(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                height: (width - 3 * width * 0.05) / 2 * 3 + width * 0.05 * 4,
                child: GridView.count(
                  childAspectRatio: 1.0,
                  mainAxisSpacing: width * 0.05,
                  crossAxisSpacing: width * 0.05,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                    serviceList.length,
                    (i) => MyServiceWidget(serviceList[i], height),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            ],
          ),
        ),
      );
    });
  }

  Container buildMyBookings(double height, double width) {
    return Container(
      height: height * 0.07,
      width: width * 0.34,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: width * 0.05,
            child: RaisedButton(
              color: Colors.white,
              shape: StadiumBorder(),
              onPressed: () {},
              child: Text(
                "My Bookings",
                style: TextStyle(foreground: Paint()..shader = linearGradient),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(6.0),
              decoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: Text(
                "10",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildGreetings(double height, double width) {
    return Container(
      height: height * 0.2,
      width: width,
      padding: EdgeInsets.only(left: width * 0.05),
      alignment: Alignment.bottomLeft,
      child: Container(
        height: height * 0.13,
        child: AutoSizeText(
          (DateTime.now().hour >= 4 ? lang.goodEvening : lang.goodMorning) +
              ",\nVenkatesh",
          style: TextStyle(
            fontSize: 500,
            fontWeight: FontWeight.bold,
            foreground: Paint()..shader = linearGradient,
          ),
        ),
      ),
    );
  }
}
