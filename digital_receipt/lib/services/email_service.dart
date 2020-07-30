import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';


final MailOptions mailOptions = MailOptions();

class EmailService {

  MailOptions mailOptions = MailOptions();
  setMail({
    @required String body,
    @required String subject,
    @required List<String> recipients,
    @required bool isHTML,
    @required List<String> bccRecipients,
    @required List<String> ccRecipients,
    @required List<String> attachments,
  }) {

    mailOptions = MailOptions(
      body: body,
      subject: subject,
      recipients: recipients,
      isHTML: isHTML,
      bccRecipients: bccRecipients,
      ccRecipients: ccRecipients,
      attachments: attachments,
    );
  }
 ///
  Future sendMail() async {
    await FlutterMailer.send(mailOptions);
  }
}
