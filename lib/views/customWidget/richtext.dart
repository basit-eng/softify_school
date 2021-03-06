import 'package:flutter/material.dart';

class RichWidget extends StatelessWidget {
  RichWidget({this.text1, this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.w500),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
          ),
        ],
      ),
    );
  }
}

class HotRichWidget extends StatelessWidget {
  HotRichWidget({this.amount, this.text2});
  final String amount;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: amount,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.w600),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
          ),
        ],
      ),
    );
  }
}
