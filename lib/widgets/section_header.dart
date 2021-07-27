import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String headerText;

  const SectionHeader(this.headerText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            headerText,
            style: textTheme.headline6!.copyWith(
              fontSize: 18,
            ),
          ),
          Spacer(),
          Text(
            "ดูเพิ่มเติม",
            style: textTheme.headline6!.copyWith(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
