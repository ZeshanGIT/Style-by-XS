import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyService {
  MyService({
    @required this.bg,
    @required this.name,
  });
  Color bg;
  String name;
}

List<MyService> serviceList = [
  MyService(bg: Colors.blue, name: "Photography"),
  MyService(bg: Colors.pink, name: "Graphic Design"),
  MyService(bg: Colors.brown, name: "Pencil Sketching"),
  MyService(bg: Colors.purple, name: "App Development"),
  MyService(bg: Colors.green, name: "Web Development"),
  MyService(bg: Colors.orangeAccent, name: "3D Printing"),
];

class MyServiceWidget extends StatefulWidget {
  final double height;
  final MyService service;

  MyServiceWidget(this.service, this.height);

  @override
  _MyServiceWidgetState createState() => _MyServiceWidgetState();
}

class _MyServiceWidgetState extends State<MyServiceWidget> {
  double padding = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          padding = 8.0;
        });
        Future.delayed(
          const Duration(milliseconds: 50),
          () {
            setState(() => padding = 0);
          },
        ).then((_) {
          Future.delayed(
            const Duration(milliseconds: 50),
            () => Navigator.pushNamed(context, "/${widget.service.name}"),
          );
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 50),
        margin: EdgeInsets.all(padding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  widget.service.bg,
                  widget.service.bg.withOpacity(0.3)
                ],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: widget.height * 0.05),
                    child: Image.asset(
                      "assets/${widget.service.name}.png",
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.only(top: widget.height * 0.01),
                    alignment: Alignment.bottomCenter,
                    height: widget.height * 0.04,
                    child: AutoSizeText(
                      widget.service.name,
                      style: TextStyle(
                        fontSize: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
