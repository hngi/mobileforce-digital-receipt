import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/create_receipt_step0.dart';

class CustomerDropdown extends StatelessWidget {
  const CustomerDropdown({
    this.customers,
    this.onSubmit,
  });
  final List customers;
  final Function onSubmit;

  @override
  Widget build(BuildContext context) {
    List<Customer> customers = Provider.of<Customer>(context).customerList;
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
                    SizedBox(height: 20),
                    customers.isEmpty
                        ? Expanded(
                            child: Column(
                            children: <Widget>[
                              Expanded(
                                child: kEmpty,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "You have not added any customer!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.3,
                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ))
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: customers.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    onSubmit(customers[index]);
                                    Navigator.pop(context);
                                  },
                                  child: ContactCard(
                                    receiptTitle: customers[index].name,
                                    subtitle: customers[index].phoneNumber,
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
