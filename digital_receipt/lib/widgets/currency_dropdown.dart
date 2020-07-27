import 'package:flutter/material.dart';
import '../constant.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({
    this.currency,
    this.onSubmit,
  });
  final List<Country> currency;
  final Function onSubmit;

  @override
  _CurrencyDropdownState createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  List<Country> searchList = [];
  @override
  void initState() {
    searchList = widget.currency;
    super.initState();
  }

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
                  color: Theme.of(context).dialogBackgroundColor,
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
                      style: TextStyle(
                        fontFamily: 'Montserrat'
                      ),
                      decoration: InputDecoration(
                        hintText: "Search currency",
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: searchList.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    widget.onSubmit(searchList[index]);
                                    Navigator.pop(context);
                                  },
                                  child: ListTile(
                                    leading: Image.asset(
                                      searchList[index].asset,
                                      package: "flutter_country_picker",
                                      height: 35,
                                      width: 46,
                                    ),
                                    title: Text(
                                      searchList[index].currency +
                                          ' (${searchList[index].currencyISO})',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "Currency not found",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
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
    setState(() {
      searchList = widget.currency
          .where((e) =>
              e.name.toLowerCase().contains(val.toLowerCase()) ||
              e.currencyISO.toLowerCase().contains(val.toLowerCase()) ||
              e.currency.toLowerCase().contains(val.toLowerCase()))
          .toList();
    });
  }
}
