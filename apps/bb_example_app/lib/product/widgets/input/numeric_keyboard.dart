import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Widget? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Widget? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceAround})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ButtonBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('1'),
            _calcButton('2'),
            _calcButton('3'),
          ],
        ),
        ButtonBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('4'),
            _calcButton('5'),
            _calcButton('6'),
          ],
        ),
        ButtonBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('7'),
            _calcButton('8'),
            _calcButton('9'),
          ],
        ),
        ButtonBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: widget.leftButtonFn,
                child: widget.leftIcon),
            _calcButton('0'),
            InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: widget.rightButtonFn,
                child: widget.rightIcon)
          ],
        ),
      ],
    );
  }

  Widget _calcButton(String value) {
    return IconButton(
      alignment: Alignment.center,
      onPressed: (){
        widget.onKeyboardTap(value);
      },
      icon: Text(
        value,
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: widget.textColor),
      ),
    );
  }
}
