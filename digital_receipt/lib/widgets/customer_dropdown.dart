import 'package:digital_receipt/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import '../widgets/create_receipt_step0.dart';

class CustomerDropdown extends StatefulWidget {
  const CustomerDropdown(
      {this.customers, this.onSubmit, });
  final List customers;
  final Function onSubmit;


  @override
  _CustomerDropdownState createState() => _CustomerDropdownState();
}

class _CustomerDropdownState extends State<CustomerDropdown> {
  @override
  void initState() {
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.customers == null
        ? CircularProgressIndicator(
            strokeWidth: 1.5,
          )
        : SizedBox(
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
                          SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget.customers.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    widget.onSubmit(widget.customers[index]);
                                    Navigator.pop(context);
                                  },
                                  child: ContactCard(
                                    receiptTitle: widget.customers[index].name,
                                    subtitle:
                                        widget.customers[index].phoneNumber,
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
}
