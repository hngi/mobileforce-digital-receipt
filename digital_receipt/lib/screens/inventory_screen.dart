import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/inventory.dart';
import 'package:digital_receipt/screens/create_inventory_screen.dart';
import 'package:digital_receipt/screens/update_inventory_screen.dart';
import 'package:digital_receipt/services/api_service.dart';
import 'package:digital_receipt/utils/receipt_util.dart';
import 'package:digital_receipt/widgets/app_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../services/shared_preference_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Inventory> inventory = [];

  Future inventFuture;
  List<Inventory> inventoryData = [];

  List<String> inventoryCategories = [];
  String dropdownValue = "ALL";
  ApiService _apiService = ApiService();
  String currency;

  @override
  void initState() {
    inventFuture = _apiService.getAllInventories();
    setCategory();
    super.initState();
  }

  setCategory() async {
    currency = await SharedPreferenceService().getStringValuesSF('Currency');
    List<Inventory> val = await inventFuture;
    List<String> temp = [];
    await Future.forEach(val, (Inventory e) {
      temp.add(e.category);
    });

    setState(() {
      inventoryCategories = temp.toSet().toList();
      inventory = val;
      inventoryData = val;
    });
  }

  @override
  void didChangeDependencies() {
    print('object');
    inventFuture = Future.delayed(Duration(seconds: 2), () async {
      var res = await _apiService.getAllInventories();
      return res;
    });
    //getInventory();
    super.didChangeDependencies();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              var data = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateInventory(),
                ),
              );
              setState(() {
                inventFuture = Future.delayed(Duration(seconds: 2), () async {
                  var res = await _apiService.getAllInventories();
                  return res;
                });
              });
              setCategory();
              print("Data from pop $data");
            },
            child: Icon(
              Icons.add,
            ),
            backgroundColor: Theme.of(context).primaryColor,
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
                  width: MediaQuery.of(context).size.width * 0.6,
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
                        items: (["ALL"] + inventoryCategories)
                            .map<DropdownMenuItem<String>>(
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
                          if (value != "ALL") {
                            setState(() {
                              dropdownValue = value;
                              print(inventory);
                            });
                            inventory = sortInventoryByCategory(inventoryData,
                                category: value);
                            print(inventory.length);
                          } else {
                            setState(() {
                              dropdownValue = value;
                              inventory = inventoryData..shuffle();
                            });
                          }
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
                      child: FutureBuilder(
                        future: inventFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                              ),
                            );
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData &&
                              snapshot.data != []) {
                            //setCategory(snapshot.data);
                            return ListView.builder(
                              itemCount: inventory.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onLongPress: () async {
                                      await _confirmInventoryDelete(
                                          inventory[index].id,
                                          inventory[index].title);
                                    },
                                    child: _buildInventory(
                                        inventory[index], index));
                              },
                            );
                          } else {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    child: kBrokenHeart,
                                    height: 170,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      "There is no inventory created!",
                                      textAlign: TextAlign.center,
                                      style:   Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildInventory(Inventory inventory, int index) {
    Widget _buildColumnText(
        {final String label,
        final String currency,
        final String value,
        final int flex}) {
      return Expanded(
        flex: flex,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style:
                  Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              label == 'UNIT PRICE' ? '$currency$value' : '$value',
            ),
          ],
        ),
      );
    }

    return GestureDetector(
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateInventory(
                  inventory: inventory,
                ),
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            children: <Widget>[
              AppCard(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(inventory.title,
                          style: Theme.of(context).textTheme.headline6),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                        children: <Widget>[
                          _buildColumnText(
                            label: "UNIT PRICE",
                            currency: currency,
                            value: inventory.unitPrice.toString(),
                            flex: 3,
                          ),
                          _buildColumnText(
                            label: "QTY",
                            value: inventory.quantity.toString(),
                            flex: 2,
                          ),
                          _buildColumnText(
                            label: "DISCOUNT",
                            value: (inventory.discount).toString() + "%",
                            flex: 3,
                          ),
                          _buildColumnText(
                            label: "TAX",
                            value: inventory.tax.toString(),
                            flex: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              index == 0
                  ? Text(
                      'Tap to update, Longpress to delete inventory',
                      //'Longpress to delete inventory',
                      textAlign: TextAlign.center,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }

  _confirmInventoryDelete(String id, String title) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            // contentPadding: EdgeInsets.all(20),
            // insetPadding: EdgeInsets.all(20),
            title: Text(
              "Are sure you want to delete $title ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 90,
                  height: 48,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.blue[50],
                    child: Text(
                      'cancel',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 90,
                  height: 48,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      var resp = await _apiService.deleteInventoryItem(id: id);
                      if (resp == 'false') {
                        setState(() {
                          loading = false;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InventoryScreen()),
                            (route) => false);
                        // OR
                        // Navigator.pop(context, true);
                        Fluttertoast.showToast(msg: 'an error occured');
                      } else {
                        setState(() {
                          loading = false;
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => InventoryScreen()),
                            (route) => false);
                        // OR
                        // Navigator.pop(context, true);
                        Fluttertoast.showToast(msg: 'item deleted');
                        print('successful');
                      }
                    },
                    color: Colors.red,
                    child: Text(
                      'delete',
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

List<Inventory> sortInventoryByCategory(List<Inventory> inventoryList,
    {String category}) {
  try {
    return inventoryList
        .where((element) => element.category == category)
        .toList();
  } catch (error) {
    Fluttertoast.showToast(
        msg: 'error, try again ',
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG);
  }
}
