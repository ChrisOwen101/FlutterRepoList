import 'package:flutter/material.dart';

class CircleImage extends StatefulWidget {
  final String url;

  CircleImage(this.url);

  @override
  _CircleImageState createState() => _CircleImageState();
}

class _CircleImageState extends State<CircleImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(widget.url ?? ''),
        ),
      ),
    );
  }
}
