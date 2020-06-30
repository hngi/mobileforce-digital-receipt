import 'package:carousel_slider/carousel_controller.dart';
import 'package:digital_receipt/models/receipt.dart';
import 'package:digital_receipt/screens/receipt_screen.dart';
import 'package:digital_receipt/services/CarouselIndex.dart';
import 'package:digital_receipt/widgets/app_textfield.dart';
import 'package:digital_receipt/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class CreateReceiptStep2 extends StatefulWidget {
  const CreateReceiptStep2({
    this.carouselController,
    this.carouselIndex,
  });
  final CarouselController carouselController;
  final CarouselIndex carouselIndex;

  @override
  _CreateReceiptStep2State createState() => _CreateReceiptStep2State();
}

class _CreateReceiptStep2State extends State<CreateReceiptStep2> {
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
              'Customization',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Tweak the look and feel to your receipt',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
                letterSpacing: 0.3,
                fontSize: 14,
                color: Colors.black,
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
              'Add receipt No (Optional)',
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
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Auto generate receipt No',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Checkbox(
                  value: true,
                  onChanged: (val) {},
                )
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Date',
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
              height: 30,
            ),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text(
                    'Select font',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3,
                      fontSize: 16,
                      color: Color(0xFF1B1B1B),
                    ),
                  ),
                ),
              ],
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
              iconEnabledColor: Color.fromRGBO(0, 0, 0, 0.87),
              hint: Text(
                'Select font',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                  fontSize: 16,
                  color: Color(0xFF1B1B1B),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF25CCB3), width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Upload signature',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.3,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.file_upload,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Your logo should be in PNG format and have a max size of 3MB (Optional)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              'Choose a color (optional)',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 33,
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ColorButton(
                        color: Colors.red,
                        onPressed: () {},
                      ),
                      ColorButton(
                        color: Color(0xFF539C30),
                        onPressed: () {},
                      ),
                      ColorButton(
                        color: Color(0xFF2C33D5),
                        onPressed: () {},
                      ),
                      ColorButton(
                        color: Color(0xFFE7D324),
                        onPressed: () {},
                      ),
                      ColorButton(
                        color: Color(0xFFC022B1),
                        onPressed: () {},
                      ),
                      ColorButton(
                        color: Color(0xFFE86C27),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Or type brand Hex code here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.3,
                  fontSize: 14,
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
              hintText: 'Enter Brand color hex code',
              hintColor: Color.fromRGBO(0, 0, 0, 0.38),
              borderWidth: 1.5,
            ),
            SizedBox(height: 37),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add paid stamp',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Color.fromRGBO(0, 0, 0, 0.87),
                  ),
                ),
                Checkbox(
                  value: true,
                  onChanged: (val) {},
                )
              ],
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Save as preset',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                    fontSize: 16,
                    color: Color.fromRGBO(0, 0, 0, 0.87),
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (val) {},
                ),
              ],
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FlatButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFF0B57A7), width: 1.5),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Save to drafts',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            SubmitButton(
              onPressed: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReceiptScreen(),
                        ),
                      );
              },
              title: 'Generate Receipt',
              textColor: Colors.white,
              backgroundColor: Color(0xFF0B57A7),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key key,
    this.onPressed,
    this.color,
  }) : super(key: key);

  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      width: 33,
      child: FlatButton(
        color: color,
        onPressed: onPressed,
        child: SizedBox.shrink(),
      ),
    );
  }
}
