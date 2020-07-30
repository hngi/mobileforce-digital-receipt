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
import '../widgets/delete_dialog.dart';

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

  Future deleteInventory(id) async {
    setState(() {
      loading = true;
    });
    var resp = await _apiService.deleteInventoryItem(id: id);
    if (resp == 'false') {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      setState(() {
        inventFuture = _apiService.getAllInventories();
      });
      setCategory();
      Fluttertoast.showToast(msg: 'an error occured');
    } else {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      setCategory();

      Fluttertoast.showToast(msg: 'item deleted');
      setState(() {
        inventFuture = _apiService.getAllInventories();
      });
    }
  }

  setCategory() async {
    currency = await SharedPreferenceService().getStringValuesSF('Currency');
    List<dynamic> val = await inventFuture;
    List<String> temp = [];
    if (val != null) {
      await Future.forEach(val, (e) {
        temp.add(e.category);
      });
    }

    setState(() {
      inventoryCategories = temp.toSet().toList();
      inventory = List.from(val);
      inventoryData = List.from(val);
    });
    // print('inventory ${inventory.isEmpty}');
  }

  @override
  void didChangeDependencies() {
    print('object');
    setState(() {
      inventFuture = _apiService.getAllInventories();
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
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateInventory(),
                ),
              );
              setState(() {
                inventFuture = _apiService.getAllInventories();
              });
              setCategory();
              // print("Data from pop $data");
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropdownValue,
                      underline: Divider(),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontFamily: 'Montserrat',
                          ),
                      items: (["ALL"] + inventoryCategories)
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                value,
                                maxLines: 1,
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
                              inventory != null &&
                              inventory.isNotEmpty) {
                            //setCategory(snapshot.data);
                            return ListView.builder(
                              itemCount: inventory.length ?? 0,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onLongPress: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (context) {
                                          return DeleteDialog(
                                              title:
                                                  "Are sure you want to delete ${inventory[index].title}?",
                                              onDelete: () async {
                                                await deleteInventory(
                                                  inventory[index].id,
                                                );
                                              });
                                        },
                                      );
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
                                      style:
                                          Theme.of(context).textTheme.headline6,
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
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateInventory(
                inventory: inventory,
              ),
            ),
          );

          setState(() {
            inventFuture = _apiService.getAllInventories();
          });
          setCategory();
        },
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
