import 'package:flutter/material.dart';
import 'package:docscan/component/constants.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final VoidCallback press;
  final Widget txt;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.txt,
  }) : super(key: key);

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: kPrimaryColor,
          onPressed: widget.press,
          child: widget.txt,
        ),
      ),
    );
  }
}
