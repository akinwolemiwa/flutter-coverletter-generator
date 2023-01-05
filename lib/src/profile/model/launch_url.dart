import 'package:url_launcher/url_launcher.dart';

Future customLaunch(link) async {
  var uri = Uri.parse(link);

  await launchUrl(uri);
}
