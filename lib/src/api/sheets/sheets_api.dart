import 'package:gsheets/gsheets.dart';
import 'package:publicart/src/api/models/graffity_data.dart';
import 'package:publicart/src/api/models/graffity_model.dart';
import 'package:publicart/src/api/models/news_data.dart';
import 'package:publicart/src/api/models/news_model.dart';

class SheetsApi {
  static const _creditials = r'''
  {
  "type": "service_account",
  "project_id": "publicart-spb",
  "private_key_id": "cdae108db59046307f3be9134dac89b5e8ccb8a1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDGH037S0xdGyj0\nbEUtxWWOLd8EJm8V4zAEQGAusqlv7ztGrDDhPU4LcbzpQ0dB0RJxFacpFwZbmujo\nIpSaP313aseYMXvtS5b5K+AQs1UNcFqv9MDn/a7R3A4eeRAIAPiigBTPvVFoMjEx\ner6zqoFBNNwG8Puh88i2tmDHBSeTWTZT8yrtfh6ZjskRYciIxC1e8c5K+9BV4G5z\nHn6oh/NqEqJieifeNUs9IfmAxkRrZOB+G9nGFnJiQWF9wfOg3y84fJAJFpvpTKTz\n/aIvWiKbh/lWQ9bXiTrBxiVUO+a8W4V8Y1HNi4FWdCtL9/4syofj/kyPG7Kj7qn7\n0Tycuy4LAgMBAAECggEADDe6/d+3XliB7ozMuVVefWWbxqw+FnnzqJd1tvuCkmoM\n3D9bJlC7At6pOTNSbh8gBYRB0jlexYBok4QqaNa4fIhDtcF7dHdAYK5Re4YrnRAM\nL6Smzseoo71vy3ZIxE2XB6JhZiw1HHlX6ka5AuhlXymM1gq/Yc3gV1Ao6K0LMz1l\nq6Z1rbdgwLvl9CQ98uYMMPK3kRSo7q5U/c9AOchntW7J6zJP56DyQrCChl04+pEU\ncxLBOooXCt3Az3ShOZeJPeIlf3q65xhFp536zmkQYoCE4rhKLNxeLFAmfutRhHsu\nSkYwqm/L/mcVqokS2D885vYyKCns53D8+32/94pZ/QKBgQD/G7nKBwqAZ/CjEJS+\no3oGaPie0oQ5zatL0u03UEVCS8woGSmN+7vCWNPV2hj26HJ6G9ldxZ3rnjWzGwZW\nBb7Kynq1q3mHnNsbXC5+EtYXl2ovAqrn609Ws62ddcA9lhQVXxbNKtwQs64crhFa\nMGUQAzTRH0morwgoKOL7FnKNBwKBgQDG0JZIFyCDnUp+DBBFde7msycLcPp0FWnj\njxszlGVvmbLuE/cvsbXP/EuHVDh6Fibg4Q8gOytepBIJNL/xdTMGj43pVpmKIJll\nXjC5u+0cLYRZd1fjCVRVlen8Yj91GCw3C6CkI/hqUhHn4AQB70d3S5vF14Hn6xbP\nlByP7LBZ3QKBgQDASDCYIwh6Ul2hOt0yd9uAu1wxsbDyNKAZLamY2IrrdmAyFQ0q\nNISH7xX0CUhpyjiG6zjCIjJuprgJAKSc8AWnqkglaFLYsZTAoZF1e1MdQwZI2rTg\ny47oZdPFbDxy7wzCMwLnr5dhi1z/xv/TP8jc8d28hd2qJAt84Zx77qZ2vwKBgBCi\n67BknwfkZZNelw347GDJpP7EGXEVSaMNGo2aYVKRXfOmIA0RpdEdn4RXe9JbgC1Z\nJ9benKZyvD+g9l7SG870vD9GS9rPF4bv9svT+eddt7F01xnccf4naUkBP6Ygu7Jv\neqXBjMv4yh7JFAzFZQmKfiJ0Ah7SATqlfi5c8/TRAoGBAIv7sbMsieavqrxU57Zw\n32i5Af8o2QT2NNfGmS5SVSge/FABTsBrCshVn5UL93RPn2wT1sY9rldkkE/kK8k3\nlXkTwRMc1/sBg9t9XOsi4ZBkrlg0okQTHJWHjsRhoBGcvfDpRI71jF1eSRwdb7OZ\n5Od7yfQxGiJWR+AO1VftBanE\n-----END PRIVATE KEY-----\n",
  "client_email": "publicart@publicart-spb.iam.gserviceaccount.com",
  "client_id": "111861378115405418838",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/publicart%40publicart-spb.iam.gserviceaccount.com"
}

  ''';
  static const _speadsheetId = '1_hreOn9e0z-k3VfO86vgcORBQ_1lvljJixIDbakKOFQ';
  static final _gsheets = GSheets(_creditials);
  static Worksheet? _graffitySheet, _newsSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_speadsheetId);
      _graffitySheet = await _getWorkSheet(spreadsheet, title: 'Граффити');
      _newsSheet = await _getWorkSheet(spreadsheet, title: 'Новости');

      // final firstGraffityRow = GraffityModel.getGraffity();
      // final firstNewsRow = NewsModel.getNews();
      // _graffitySheet!.values.insertRow(1, firstGraffityRow);
      // _newsSheet!.values.insertRow(1, firstNewsRow);
    } catch (e) {
      print('SpredSheetERRORRRR: $e');
    }
  }

  static Future<int> getGraffityRowCount() async {
    if (_graffitySheet == null) {
      print('_graffitySheet == null');
      return 0;
    }
    final lastRow = await _graffitySheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<int> getNewsRowCount() async {
    if (_newsSheet == null) {
      print('_newsSheet = null');
      return 0;
    }
    final lastRow = await _newsSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<GraffityData?> getGraffityById(int id) async {
    if (_graffitySheet == null) return null;

    final json = await _graffitySheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : GraffityData.fromJson(json);
  }

  static Future getNewsById(int id) async {
    if (_newsSheet == null) return null;

    final json = await _newsSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : NewsData.fromJson(json);
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
}
