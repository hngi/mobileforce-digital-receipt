import 'package:digital_receipt/widgets/CardTile.dart';
import 'package:flutter/material.dart';

class ProductDisplay extends StatefulWidget {
  final List items;

  const ProductDisplay({Key key, this.items}) : super(key: key);
  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {


  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return items.isEmpty ? Text('empty') : ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index){
        return Dismissible(
          key: ValueKey(items[index].id), 
          direction: DismissDirection.endToStart,
          background: Container(color: Colors.grey[300],child: Center(child: Text('Delete Product', style: TextStyle(fontSize: 25),)),),
          onDismissed: (direction){
            setState(() {
              items.removeAt(index);
            });
          },
          child: Column(
            children: <Widget>[
              CardTile(label: items[index].productDesc, amount: 'N' + items[index].amount.toString()),
              SizedBox(height: 10,),
              Text(
                  'Tap to edit, Swipe to delete', 
                 style: TextStyle(
                  color: Colors.black38,
                  wordSpacing: 5,
                  fontSize: 15, 
                  fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10,),
            ],
          )
          );
      }
      );
  }
}




