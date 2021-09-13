import 'package:flutter/material.dart';
import 'package:fundo_notes/screens/base_screen.dart';

class Color_slider extends StatefulWidget {
  final Function onSelectColor;
  final List<Color> availableColors;
  final Color initialColor;
  final bool circleItem;

  Color_slider(
      {required this.onSelectColor,
      required this.availableColors,
      required this.initialColor,
      this.circleItem = true});
  @override
  Color_sliderState createState() => new Color_sliderState();
}

class Color_sliderState extends State<Color_slider> {
  late Color _pickedColor;

  void initState() {
    _pickedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.availableColors.length,
        itemBuilder: (context, index) {
          final itemColor = widget.availableColors[index];
          return InkWell(
              onTap: () {
                widget.onSelectColor(itemColor);
                setState(() {
                  _pickedColor = itemColor;
                  print('_pickedColor:$_pickedColor');
                });
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: 50,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: itemColor,
                      shape: widget.circleItem == true
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      border:
                          Border.all(width: 1, color: Colors.grey.shade300)),
                  child: itemColor == _pickedColor
                      ? Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        )
                      : Container(),
                ),
              ));
        },
      ),
    );
  }
}
