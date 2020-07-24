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
                  color: Theme.of(context).dialogBackgroundColor,
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
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.all(15),
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
                                style: Theme.of(context).textTheme.headline6,
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
