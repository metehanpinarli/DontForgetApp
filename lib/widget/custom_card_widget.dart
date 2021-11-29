import 'package:dont_forget/widget/card_contents_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(context.normalRadius),
      ),
      child:const AspectRatio(
        aspectRatio: 3 / 2,
        child:CardContents(),
      ),
    );
  }
}