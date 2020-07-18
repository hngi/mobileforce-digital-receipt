import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/screens/create_inventory_screen.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:flutter/material.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Inventory> inventory;
  String dropdownValue = "Category";
  ApiService _apiService = ApiService();

  @override
  void initState() {
    getInventory();
    super.initState();
  }

  getInventory() async {
    await _apiService.getAllInventories().then((value) {
      print('value of resp : $value');
      setState(() {
        inventory = value;
      });
    });
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print(inventory);
    if (inventory == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFFF2F8FF),
        appBar: AppBar(
          backgroundColor: Color(0xFF0B57A7),
          title: Text(
            'Inventory',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              fontSize: 16,
              //color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: SafeArea(
          child: FloatingActionButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CreateInventory()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            backgroundColor: kPrimaryColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 16, right: 16),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text("Sort By"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color(0xff25CCB3),
                    ),
                  ),
                  child: SizedBox(
                    height: 40,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: dropdownValue,
                        underline: Divider(),
                        items: <String>[
                          'Category',
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  value,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String value) {
                          setState(() => dropdownValue = value);
                          // No logic Implemented
                        },
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 20.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Flexible(
                      child: ListView.builder(
                        itemCount: inventory.length,
                        itemBuilder: (context, index) {
                          return _buildInventory(inventory[index]);
                          // header: 'Shoes',
                          // color: Colors.red,
                          // items: List<Inventory>.generate(
                          // 6,
                          // (index) => Inventory(
                          //     category: inventory[index].category,
                          //     title: inventory[index].title,
                          //     unitPrice:inventory[index].unitPrice ,
                          //     quantity: inventory[index].quantity,
                          //     discount: inventory[index].discount,
                          //     tax: inventory[index].tax),
                          // ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildInventory(Inventory inventory) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff539C30),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          margin: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
            color: Color(0xffE8F1FB),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inventory.title,
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 0.87),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    //color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "UNIT PRICE",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            inventory.unitPrice.toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "QTY",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            '${(inventory.quantity).toString()} per/${(inventory.unit).toString()}',
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
/*                     Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "DISCOUNT",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            (inventory.discount).toString() + "%",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "TAX",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            (inventory.tax).toString(),
                            style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.87),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              letterSpacing: 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  */
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<Widget> itemsWidget = [];
  // items.forEach((element) {
  //   itemsWidget.add(_buildInventory(element));
  // });

  // return Container(
  //   child: Column(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       // Text(
  //       //   '$header',
  //       //   style: TextStyle(
  //       //     fontFamily: 'Montserrat',
  //       //     color: Color.fromRGBO(0, 0, 0, 0.87),
  //       //     fontWeight: FontWeight.w600,
  //       //     letterSpacing: 0.3,
  //       //     fontSize: 22,
  //       //     //color: Colors.white,
  //       //   ),
  //       // ),
  //       SizedBox(
  //         height: 20,
  //       ),
  //       Column(
  //         children: itemsWidget,
  //       ),
  //       SizedBox(
  //         height: 40,
  //       )
  //     ],
  //   ),
  // );
}
// }
