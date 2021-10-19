import 'package:shared_preferences/shared_preferences.dart';
import 'package:studio_booking_app/Values/constants.dart';

class SharedPref{
  setFirstArtist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(alreadyUsed, true);
  }
  Future<bool> getFirstArtist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool first = (prefs.getBool(alreadyUsed) ?? false);
    return first;
  }

  setFirstStudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(alreadyUsed2, true);
  }
  Future<bool> getFirstStudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool first = (prefs.getBool(alreadyUsed2) ?? false);
    return first;
  }

  setArtist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(client, 1);
  }
  setStudio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(client, 2);
  }

  Future<int> getChoiceOfClient() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int first = (prefs.getInt(client) ?? 0);
    return first;
  }

}