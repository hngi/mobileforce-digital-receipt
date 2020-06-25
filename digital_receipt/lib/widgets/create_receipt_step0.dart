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
                fontSize: 12,
                color: Color(0xFF141414),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DropdownButtonFormField(
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
                  child: Text('Instergram'),
                ),
                DropdownMenuItem(
                  child: Text('Facebook'),
                ),
                DropdownMenuItem(
                  child: Text('Tweeter'),
                ),
                DropdownMenuItem(
                  child: Text('Create cartegory'),
                ),
              ],
              iconEnabledColor: Color.fromRGBO(0, 0, 0, 0.87),
              onChanged: (val) {},
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
              'This information is displayed in the receipt',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 14,
                color: Color(0xFF141414),
              ),
            ),
            SizedBox(
              height: 13,
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
}
