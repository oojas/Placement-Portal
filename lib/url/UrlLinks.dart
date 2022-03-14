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

  launchURLForWebsite() async {
    const url = 'https://ojas-gupta.web.app/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURLForLinkedin() async {
    const url = 'https://www.linkedin.com/in/ojasgupta13/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURLForInstagram() async {
    const url = 'https://www.instagram.com/ojas_xo/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURLForThumbnail1() async {
    const url = 'https://youtu.be/KZehm-meGMg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchURLForThumbnail2() async {
    const url = 'https://youtu.be/YeEO0DtENUo';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  launchURLForThumbnail3() async {
    const url = 'https://youtu.be/EvId_K83-5M';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
