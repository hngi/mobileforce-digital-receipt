import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/create_receipt_step0.dart';

class CurrencyDropdown extends StatelessWidget {
  // const CustomerDropdown({
  //   this.customers,
  //   this.onSubmit,
  // });
  // final List customers;
  // final Function onSubmit;
  List<Currency> currency = Currency.currencyList();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 100,
          bottom: 10,
          left: 25,
          right: 25,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.0),
              ),
              child: ListView(
                children: <Widget>[
                  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
      ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: TextFormField(
                        onChanged: (val) {
                          //print('jhj');
                          Provider.of<Customer>(context, listen: false)
                              .searchCustomerList(val);
                        },
                        decoration: InputDecoration(
                          hintText: "Search customer",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 0.38),
                              fontFamily: 'Montserrat'),
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            color: Color.fromRGBO(0, 0, 0, 0.38),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(0, 0, 0, 0.12),
                              width: 1,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFFC8C8C8),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
      ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width - 52,
                    child: ListView.builder(
                        itemCount: currency.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width - 200,
                            height: MediaQuery.of(context).size.height - 770,
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  trailing:
                                      Text(currency[index].flag.toString()),
                                  title: Text(currency[index].currencyName),
                                  leading: Text(currency[index].currencySymbol),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
