import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RangePicker extends StatelessWidget {
  final int initialItem;
  final int rangeStart;
  final int rangeEnd;
  final String unit;
  final Function(int) onItemChanged;

  const RangePicker({
    Key? key,
    required this.initialItem,
    required this.rangeStart,
    required this.rangeEnd,
    required this.unit,
    required this.onItemChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      scrollController: FixedExtentScrollController(initialItem: initialItem),
      onSelectedItemChanged: onItemChanged,
      children: List<Widget>.generate(rangeEnd - rangeStart + 1, (int index) {
        return Center(
          child: Text('${rangeStart + index} $unit'),
        );
      }),
    );
  }
}
