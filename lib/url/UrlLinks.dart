// ignore for file: unused_element
import 'package:url_launcher/url_launcher.dart';

class URL {
  // ignore: unused_element
  launchURLForFeedback() async {
    const url = 'https://forms.gle/qkuKJyLZveTbharB9';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
