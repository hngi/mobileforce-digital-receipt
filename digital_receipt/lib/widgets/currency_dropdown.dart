import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/currency.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/create_receipt_step0.dart';

class CurrencyDropdown extends StatelessWidget {
  const CurrencyDropdown({
    this.currency,
    this.onSubmit,
  });
  final List currency;
  final Function onSubmit;
  // List<Currency> currency = Currency.currencyList();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 10,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF2F8FF),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width - 32,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val) {
                        //print('jhj');
                        searchCurrencyList(val);
                      },
                      decoration: InputDecoration(
                        hintText: "Search currency",
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
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: currency.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              onSubmit(currency[index]);
                              Navigator.pop(context);
                            },
                            child: ListTile(
                              leading: Text(currency[index].flag),
                              title: Text(currency[index].currencyName),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
      searchCurrencyList(String val) {
    //print(_customerList[0].name.contains(val));
    currency
        .where((e) => e.name.toLowerCase().contains(val.toLowerCase()))
        .toList();
    print('ok: $currency');
    // print('kkk: $tempCustomerLi');
  }
}
