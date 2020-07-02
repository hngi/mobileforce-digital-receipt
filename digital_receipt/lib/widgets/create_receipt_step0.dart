import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateReceiptStep0 extends StatefulWidget {
  const CreateReceiptStep0({this.carouselController, this.carouselIndex});

  final CarouselController carouselController;
  final CarouselIndex carouselIndex;
  @override
  _CreateReceiptStep0State createState() => _CreateReceiptStep0State();
}

class _CreateReceiptStep0State extends State<CreateReceiptStep0> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  dynamic selectedCategory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 14,
            ),
            Text(
              'Create a receipt',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Lets get started',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: map<Widget>([1, 1, 2], (index, url) {
                    print(index);
                    return GestureDetector(
                      onTap: () {
                        widget.carouselController.animateToPage(index);
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 2,
                            width: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: widget.carouselIndex.index == index
                                    ? Color(0xFF25CCB3)
                                    : Color.fromRGBO(0, 0, 0, 0.12),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 6,
                                      color: Color.fromRGBO(0, 0, 0, 0.16))
                                ]),
                          ),
                          index != 2 ? SizedBox(width: 10) : SizedBox.shrink()
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'This helps you track your sales from different platforms',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3,
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
              value: selectedCategory,
              items: [
                DropdownMenuItem(
                  child: Text(
                    'Category',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.3,
                      fontSize: 16,
                      color: Color(0xFF1B1B1B),
                    ),
                  ),
                ),
                DropdownMenuItem(
                  child: Text('WhatsApp'),
                ),
                DropdownMenuItem(
                  child: Text('Instagram'),
                ),
                DropdownMenuItem(
                  child: Text('Facebook'),
                ),
                DropdownMenuItem(
                  child: Text('Twitter'),
                ),
                DropdownMenuItem(
                  child: Text('Others'),
                ),
              ],
              iconEnabledColor: Color.fromRGBO(0, 0, 0, 0.87),
              onChanged: (val) {
                setState(() {
                  selectedCategory = val;
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Color(0xFFC8C8C8),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(),
                //hintText: hintText,
                hintStyle: TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(
              height: 39,
            ),
            Text(
              'Customer information',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                fontSize: 16,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'This information is displayed in the receipt.\nIf the customer is saved, select customer.',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: (){
                _selectCustomerDropdown(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFC8C8C8),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                ),
                padding: EdgeInsets.symmetric(horizontal:13, vertical: 14),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Select Customer',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500, letterSpacing: 0.3,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Otherwise, enter customer information',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 14,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text(
              'Customer name',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 13,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(height: 5),
            AppTextField(),
            SizedBox(height: 22),
            Text(
              'Email address',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 13,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(height: 5),
            AppTextField(
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              'Address',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 13,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(height: 5),
            AppTextField(),
            SizedBox(
              height: 22,
            ),
            Text(
              'Phone number',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 13,
                color: Color.fromRGBO(0, 0, 0, 0.6),
              ),
            ),
            SizedBox(height: 5),
            AppTextField(
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Save to customer list',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (val) {},
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            DropdownButtonFormField(
              items: [],
              onChanged: (val) {},
              iconDisabledColor: Color.fromRGBO(0, 0, 0, 0.87),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Color(0xFFC8C8C8),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(),
                //hintText: hintText,
                hintStyle: TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
              hint: Text(
                'Select currency',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Color(0xFF1B1B1B),
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            SubmitButton(
              title: 'Next',
              textColor: Colors.white,
              backgroundColor: Color(0xFF0B57A7),
              onPressed: () {
                widget.carouselController.animateToPage(1);
              },
            )
          ],
        ),
      ),
    );
  }

  void _selectCustomerDropdown(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(0xFFF2F8FF)),
        height: 500,
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ContactCard(
                        receiptTitle: "Carole Froschauer",
                        subtitle: "741-142-4459");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => simpleDialog);
  }
  Widget ContactCard({String receiptNo, total, date, receiptTitle, subtitle}) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF539C30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Color(0xFFE2EAF3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                    child: Text(
                      "$receiptTitle",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.87),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.03,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 102.0, 5.0),
                    child: Text(
                      "$subtitle",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        height: 1.43,
                        fontFamily: 'Montserrat',
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
