import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/CardTile.dart';
import 'package:flutter/material.dart';

class ProductDisplay extends StatefulWidget {
  final List items;
  final Function updateFn;
  final Function showBottomSheet;

  const ProductDisplay(
      {Key key, this.items, this.updateFn, this.showBottomSheet})
      : super(key: key);
  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return items.isEmpty
        ? Text('empty')
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Dismissible(
                  key: ValueKey(items[index].id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.grey[300],
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Delete Product',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                  child: Column(
                    children: <Widget>[
                      CardTile(
                        label: items[index].productDesc,
                        amount: 'N${Utils.formatNumber(items[index].amount)}',
                        displaySheet: widget.showBottomSheet,
                        index: index,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //     'Tap to edit, Swipe to delete',
                      //    style: TextStyle(
                      //       fontFamily: 'Montserrat',
                      //       fontWeight: FontWeight.normal,
                      //       letterSpacing: 0.3,
                      //       fontSize: 12,
                      //       color: Colors.black,
                      //     ),
                      // ),
                      //   SizedBox(height: 10,),
                    ],
                  ));
            });
  }
}
