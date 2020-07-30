import 'package:flutter/material.dart';

import '../constant.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {this.receiptNo,
      this.total,
      this.date,
      this.receiptTitle,
      this.subtitle});
  final String receiptNo;
  final total;
  final date;
  final receiptTitle;
  final subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 71,
            decoration: BoxDecoration(
              color: Color(0xFF539C30),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Card(
              margin: EdgeInsets.only(left: 5.0),
              shape: kRoundedRectangleBorder,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: Text(
                      "$receiptTitle",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 102.0, 5.0),
                    child: Text(
                      "$subtitle",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
