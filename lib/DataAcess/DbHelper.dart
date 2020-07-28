import 'package:onder2020/models/commisions_model.dart';
import 'package:onder2020/models/connection_model.dart';
import 'package:onder2020/models/news_model.dart';
import 'package:onder2020/models/stable_pages_model.dart';
import 'package:onder2020/models/swiper_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbHelper {
  String tblCommisions = "Commissions";
  String tblConnection = "Connection";
  String tblMenu = "Menu";
  String tblNews = "News";
  String tblStablePages = "StablePages";
  String tblSwiper = "Swiper";

  String colText = "text";

  String colCategory = "category";
  String colDate = "date";
  String colUpdateDate = "updateDate";

  String colSubMenu = "subMenu";
  String colTabID = "tabID";

  String colName = "name";
  String colAdress = "adress";
  String colEmail = "email";
  String colGsm = "gsm";

  String colPic = "pic";
  String colTitle = "title";
  String colDetails = "detail";
  String colLink = "link";
  String colOrder = "colOrder";
  String colId = "id";

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  static Database _db;
  Future<Database> initilizeDb() async {
    var dbOnder = await openDatabase("lib/DataAcess/onderMobilev1.db",
        version: 1, onCreate: _createDb);
    return dbOnder;
  }

  Future<Database> get db async {
    if (_db == null) {
      String text =
          "xLBtYW0gSGF0aXAgTGlzZWxlcmluaW4gaWxrIG7DvHZlc2k7IE9zbWFubMSxIERldmxldGnigJluaW4gc29uIGTDtm5lbWluZGUgdmFpeiB5ZXRpxZ90aXJtZWsgYW1hY8SxeWxhIDE5MTIgecSxbMSxbmRhIGHDp8SxbGFuIE1lZHJlc2V0w7zigJlsLVZhaXppbiBpbGUgaW1hbSB2ZSBoYXRpcCB5ZXRpxZ90aXJtZWsgw7x6ZXJlIDE5MTPigJl0ZSBhw6fEsWxhbiBNZWRyZXNldMO84oCZbC1FaW1tZSB2ZeKAmWwtSHV0ZWJh4oCZZMSxci4gQnUgaWtpIG1lZHJlc2UgMTkxOeKAmWRhIE1lZHJlc2V0w7zigJlsLcSwcsWfYWQgYWTEsXlsYSBiaXJsZcWfdGlyaWxkaS4KCkJ1bmRhbiBpa2kgecSxbCBzb25yYSwgOCBNYXnEsXMgMTkyMeKAmWRlIE1lZMOicmlzLWkgxLBsbWl5ZSBOaXphbW5hbWVzaSwgeWFuaSAiQmlsaW0gTWVkcmVzZWxlcmkgS2FudW5uYW1lc2nigJ0gw6fEsWt0xLEuIEJ1IG5pemFtbmFtZSwgxLBtYW0gSGF0aXAgTGlzZWxlcmluaW4gaWxrIHByb3RvdGlwaSBvbGFyYWsga2FidWwgZWRpbGViaWxlY2VrIG9sYW4gb2t1bGxhcsSxbiBtw7xmcmVkYXTEsW7EsSwgYnVnw7xua8O8IGltYW0gaGF0aXAgb2t1bGxhcsSxbsSxbiBtw7xmcmVkYXTEsW5hIGJlbnplciBiaXIgxZ9la2lsZGUgZMO8emVubGVtacWfdGkuIFRCTU0gdGFyYWbEsW5kYW4gYcOnxLFsYXJhayBzYXnEsWxhcsSxIDQ2NcK0aSBidWxhbiB2ZSBoZW0gZmVuIGJpbGltbGVyaSwgaGVtIGRlIGRpbmkgYmlsaW1sZXJpbiBiaXIgYXJhZGEgdmVyaWxkacSfaSBidSBpbGsgQ3VtaHVyaXlldCBva3VsbGFyxLEsIDE5MjQgecSxbMSxbmRhIFRldmhpZC1pIFRlZHJpc2F0IEthbnVudcK0bnVuIGthYnVsIGVkaWxtZXNpbmRlbiBzb25yYSBrYXBhdMSxbGTEsS4gWWVuaSBrYW51bmxhIGJpcmxpa3RlIGlsayBrZXogImltYW0gaGF0aXAiIGlzbWkgZGUga3VsbGFuxLFsbWF5YSBiYcWfbGFkxLEuIFllbmkga2FudW4gZGluIGFkYW3EsSB5ZXRpxZ90aXJtZWsgw7x6ZXJlICLEsG1hbSBIYXRpcCBNZWt0ZXBsZXJpIiBhw6fEsWxtYXPEsW7EsSDDtm5nw7Zyw7x5b3JkdS4gQW5jYWsga2FwYXTEsWxhbiB5w7x6bGVyY2UgbWVkcmVzZSBrYXLFn8SxbMSxxJ/EsW5kYSBzYWRlY2UgMjkgeWVyZGUgxLBtYW0gSGF0aXAgTWVrdGViaSBhw6fEsWxkxLEuIEJ1IHNhecSxIGlzZSBoZXIgecSxbCBiaXJheiBkYWhhIGF6YWxhcmFrIDE5MzLigJlkZSDEsG1hbSBIYXRpcCBNZWt0ZXBsZXJpIHRhbWFtZW4ga2FwYXTEsWxkxLEuCgpPa3VsbGFyLCAxOTQ5IHnEsWzEsW5kYSB0ZWtyYXIgYcOnxLFsZMSxxJ/EsW5kYSBhZMSxIOKAnMSwbWFtIEhhdGlwIEt1cnNsYXLEseKAnXlkxLEuIERlbW9rcmF0IFBhcnRpIGlrdGlkYXLEsSBzb25yYXPEsW5kYSBDZWxhbGVkZGluIMOWa3RlbiBob2NhbsSxbiBwcm9qZXNpbmkgaGF6xLFybGF5xLFwIGjDvGvDvG1ldGUga2FidWwgZXR0aXJkacSfaSBpbWFtIGhhdGlwIG9rdWxsYXLEsSBpc2UgMTk1MSB5xLFsxLFuZGEgeWVuaWRlbiBhw6fEsWxkxLEuIMSwbGsga3VydWxhbiBva3VsIMSwc3RhbmJ1bCDEsG1hbSBIYXRpcCBMaXNlc2kgb2x1cmtlbiwgb251IDYgb2t1bCBkYWhhIHRha2lwIGV0dGkuIEF5bsSxIHnEsWwsIMSwc3RhbmJ1bCwgQW5rYXJhLCBLb255YSwgQWRhbmEsIElzcGFydGEsIEtheXNlcmkgdmUgS2FocmFtYW5tYXJhxZ8ndGEgaWxrIGltYW0gaGF0aXAgb2t1bGxhcsSxIGHDp8SxbGTEsS4gMTk2OSB5xLFsxLFuZGEgZGEgSXNwYXJ0YeKAmWRhIGlsayBrxLF6IGltYW0gaGF0aXAgb2t1bHVudW4gdGVtZWxpIGF0xLFsZMSxLgoKxLBtYW0gaGF0aXBsZXJsZSBpbGdpbGkgYnUgZ2VsacWfbWVsZXIgeWHFn2FuxLFya2VuLCDEsHN0YW5idWwgxLBtYW0gSGF0aXAgT2t1bHVgbnVuIGlsayBtZXp1bmxhcsSxIHRhcmFmxLFuZGFuIDE5NTggecSxbMSxbmRhIOKAnMSwc3RhbmJ1bCDEsG1hbSBIYXRpcCBPa3VsdSBNZXp1bmxhciBDZW1peWV0aeKAnSBpc21peWxlIGRlcm5lxJ9pbWl6IGt1cnVsZHUuIDE5ODAgxLBodGlsYWxpYG5kZW4gc29ucmEgaXNtaW5kZWtpICLEsHN0YW5idWwiIGlmYWRlc2kgw6fEsWthcsSxbGTEsS4gxLBtYW0ga2VsaW1lc2luaW4gVMO8cmvDp2Uga2FyxZ/EsWzEscSfxLEgb2xhbiAiw5ZOREVSIiBpYmFyZXNpIGVrbGVuZXJlayBpc21pIMOWTkRFUiDEsG1hbSBIYXRpcGxpbGVyIERlcm5lxJ9pIG9sZHUuCgpEZXZhbSBlZGVuIHnEsWxsYXJkYSBwZWsgw6dvayB5ZW5pbGlrLCBkZcSfacWfaWtsaWsgeWHFn2FuZMSxIGFuY2FrIGltYW0gaGF0aXBsZXJpbiBoYXlhdMSxIGhlcCBtw7xjYWRlbGV5bGUgZ2XDp3RpLiAxOTk3IHnEsWzEsW5kYSBpc2UgaW1hbSBoYXRpcGxlcmkgMjggxZ51YmF0IGRhcmJlc2kgdnVyZHUuIE9rdWxsYXLEsW4gb3J0YSBrxLFzbcSxIGthcGF0xLFsxLFya2VuLCDDvG5pdmVyc2l0ZXllIGdlw6dpxZ90ZSBrYXRzYXnEsSBlbmdlbGkga29uZHUuIDIwMDnigJlkYSBrYXRzYXnEsSB1eWd1bGFtYXPEsSBrYWxkxLFyxLFsZMSxLCAyMDEy4oCZZGUgZGUgMTUgecSxbCBhcmFkYW4gc29ucmEgaW1hbSBoYXRpcCBva3VsbGFyxLFuxLFuIG9ydGEga8Sxc23EsSB5ZW5pZGVuIGHDp8SxbGTEsS4gQnVnw7xuIFTDvHJraXll4oCZZGUg4oCccHJvamUgb2t1bGxhcuKAnSBiYcWfbMSxxJ/EsSBhbHTEsW5kYSBmZW4gdmUgc29zeWFsIGJpbGltbGVyLCBkaWwsIHNhbmF0LCBzcG9yIHZlIGhhZsSxemzEsWsgYWxhbsSxbmRha2kgaW1hbSBoYXRpcGxlcmluIHlhbsSxc8SxcmEsIHVsdXNsYXJhcmFzxLEgaW1hbSBoYXRpcGxlciBkZSBmYWFsaXlldCBnw7ZzdGVyaXlvci4gWXVydGTEscWfxLFuZGEgaXNlIDIyIMO8bGtlZGUgNTQgaW1hbSBoYXRpcCBsaXNlc2kgYnVsdW51eW9yLg==";
      String photoNews =
          "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";
      String commisionPhoto =
          "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";
      String tarihce =
          "PGRpdiBpZD0ic2F5ZmFfMSIgY2xhc3M9ImNvbC14cy0xMiB0YWItcGFuZSBmYWRlIGluIGFjdGl2ZSI+CiAgICAgICAgICAgICAgICA8cD48c3Ryb25nPsSwTUFNIEhBVMSwUExFUjogWcOcWiBZSUxMSUsgR0VMRU5FSzwvc3Ryb25nPjwvcD4KCjxwPsSwbWFtIEhhdGlwIExpc2VsZXJpbmluIGlsayBuw7x2ZXNpOyBPc21hbmzEsSBEZXZsZXRp4oCZbmluIHNvbiBkw7ZuZW1pbmRlIHZhaXogeWV0acWfdGlybWVrIGFtYWPEsXlsYSAxOTEyIHnEsWzEsW5kYSBhw6fEsWxhbiBNZWRyZXNldMO84oCZbC1WYWl6aW4gaWxlIGltYW0gdmUgaGF0aXAgeWV0acWfdGlybWVrIMO8emVyZSAxOTEz4oCZdGUgYcOnxLFsYW4gTWVkcmVzZXTDvOKAmWwtRWltbWUgdmXigJlsLUh1dGViYeKAmWTEsXIuIEJ1IGlraSBtZWRyZXNlIDE5MTnigJlkYSBNZWRyZXNldMO84oCZbC3EsHLFn2FkIGFkxLF5bGEgYmlybGXFn3RpcmlsZGkuPC9wPgoKPHA+QnVuZGFuIGlraSB5xLFsIHNvbnJhLCA4IE1hecSxcyAxOTIx4oCZZGUgTWVkw6JyaXMtaSDEsGxtaXllIE5pemFtbmFtZXNpLCB5YW5pICJCaWxpbSBNZWRyZXNlbGVyaSBLYW51bm5hbWVzaeKAnSDDp8Sxa3TEsS4gQnUgbml6YW1uYW1lLCDEsG1hbSBIYXRpcCBMaXNlbGVyaW5pbiBpbGsgcHJvdG90aXBpIG9sYXJhayBrYWJ1bCBlZGlsZWJpbGVjZWsgb2xhbiBva3VsbGFyxLFuIG3DvGZyZWRhdMSxbsSxLCBidWfDvG5rw7wgaW1hbSBoYXRpcCBva3VsbGFyxLFuxLFuIG3DvGZyZWRhdMSxbmEgYmVuemVyIGJpciDFn2VraWxkZSBkw7x6ZW5sZW1pxZ90aS4gVEJNTSB0YXJhZsSxbmRhbiBhw6fEsWxhcmFrIHNhecSxbGFyxLEgNDY1wrRpIGJ1bGFuIHZlIGhlbSBmZW4gYmlsaW1sZXJpLCBoZW0gZGUgZGluaSBiaWxpbWxlcmluIGJpciBhcmFkYSB2ZXJpbGRpxJ9pIGJ1IGlsayBDdW1odXJpeWV0IG9rdWxsYXLEsSwgMTkyNCB5xLFsxLFuZGEgVGV2aGlkLWkgVGVkcmlzYXQgS2FudW51wrRudW4ga2FidWwgZWRpbG1lc2luZGVuIHNvbnJhIGthcGF0xLFsZMSxLiBZZW5pIGthbnVubGEgYmlybGlrdGUgaWxrIGtleiAiaW1hbSBoYXRpcCIgaXNtaSBkZSBrdWxsYW7EsWxtYXlhIGJhxZ9sYWTEsS4gWWVuaSBrYW51biBkaW4gYWRhbcSxIHlldGnFn3Rpcm1layDDvHplcmUgIsSwbWFtIEhhdGlwIE1la3RlcGxlcmkiIGHDp8SxbG1hc8SxbsSxIMO2bmfDtnLDvHlvcmR1LiBBbmNhayBrYXBhdMSxbGFuIHnDvHpsZXJjZSBtZWRyZXNlIGthcsWfxLFsxLHEn8SxbmRhIHNhZGVjZSAyOSB5ZXJkZSDEsG1hbSBIYXRpcCBNZWt0ZWJpIGHDp8SxbGTEsS4gQnUgc2F5xLEgaXNlIGhlciB5xLFsIGJpcmF6IGRhaGEgYXphbGFyYWsgMTkzMuKAmWRlIMSwbWFtIEhhdGlwIE1la3RlcGxlcmkgdGFtYW1lbiBrYXBhdMSxbGTEsS48L3A+Cgo8cD5Pa3VsbGFyLCAxOTQ5IHnEsWzEsW5kYSB0ZWtyYXIgYcOnxLFsZMSxxJ/EsW5kYSBhZMSxIOKAnMSwbWFtIEhhdGlwIEt1cnNsYXLEseKAnXlkxLEuIERlbW9rcmF0IFBhcnRpIGlrdGlkYXLEsSBzb25yYXPEsW5kYSBDZWxhbGVkZGluIMOWa3RlbiBob2NhbsSxbiBwcm9qZXNpbmkgaGF6xLFybGF5xLFwIGjDvGvDvG1ldGUga2FidWwgZXR0aXJkacSfaSBpbWFtIGhhdGlwIG9rdWxsYXLEsSBpc2UgMTk1MSB5xLFsxLFuZGEgeWVuaWRlbiBhw6fEsWxkxLEuIMSwbGsga3VydWxhbiBva3VsIMSwc3RhbmJ1bCDEsG1hbSBIYXRpcCBMaXNlc2kgb2x1cmtlbiwgb251IDYgb2t1bCBkYWhhIHRha2lwIGV0dGkuIEF5bsSxIHnEsWwsIMSwc3RhbmJ1bCwgQW5rYXJhLCBLb255YSwgQWRhbmEsIElzcGFydGEsIEtheXNlcmkgdmUgS2FocmFtYW5tYXJhxZ8ndGEgaWxrIGltYW0gaGF0aXAgb2t1bGxhcsSxIGHDp8SxbGTEsS4gMTk2OSB5xLFsxLFuZGEgZGEgSXNwYXJ0YeKAmWRhIGlsayBrxLF6IGltYW0gaGF0aXAgb2t1bHVudW4gdGVtZWxpIGF0xLFsZMSxLjwvcD4KCjxwPsSwbWFtIGhhdGlwbGVybGUgaWxnaWxpIGJ1IGdlbGnFn21lbGVyIHlhxZ9hbsSxcmtlbiwgxLBzdGFuYnVsIMSwbWFtIEhhdGlwIE9rdWx1YG51biBpbGsgbWV6dW5sYXLEsSB0YXJhZsSxbmRhbiAxOTU4IHnEsWzEsW5kYSDigJzEsHN0YW5idWwgxLBtYW0gSGF0aXAgT2t1bHUgTWV6dW5sYXIgQ2VtaXlldGnigJ0gaXNtaXlsZSBkZXJuZcSfaW1peiBrdXJ1bGR1LiAxOTgwIMSwaHRpbGFsaWBuZGVuIHNvbnJhIGlzbWluZGVraSAixLBzdGFuYnVsIiBpZmFkZXNpIMOnxLFrYXLEsWxkxLEuIMSwbWFtIGtlbGltZXNpbmluIFTDvHJrw6dlIGthcsWfxLFsxLHEn8SxIG9sYW4gIsOWTkRFUiIgaWJhcmVzaSBla2xlbmVyZWsgaXNtaSDDlk5ERVIgxLBtYW0gSGF0aXBsaWxlciBEZXJuZcSfaSBvbGR1LjwvcD4KCjxwPkRldmFtIGVkZW4gecSxbGxhcmRhIHBlayDDp29rIHllbmlsaWssIGRlxJ9pxZ9pa2xpayB5YcWfYW5kxLEgYW5jYWsgaW1hbSBoYXRpcGxlcmluIGhheWF0xLEgaGVwIG3DvGNhZGVsZXlsZSBnZcOndGkuIDE5OTcgecSxbMSxbmRhIGlzZSBpbWFtIGhhdGlwbGVyaSAyOCDFnnViYXQgZGFyYmVzaSB2dXJkdS4gT2t1bGxhcsSxbiBvcnRhIGvEsXNtxLEga2FwYXTEsWzEsXJrZW4sIMO8bml2ZXJzaXRleWUgZ2XDp2nFn3RlIGthdHNhecSxIGVuZ2VsaSBrb25kdS4gMjAwOeKAmWRhIGthdHNhecSxIHV5Z3VsYW1hc8SxIGthbGTEsXLEsWxkxLEsIDIwMTLigJlkZSBkZSAxNSB5xLFsIGFyYWRhbiBzb25yYSBpbWFtIGhhdGlwIG9rdWxsYXLEsW7EsW4gb3J0YSBrxLFzbcSxIHllbmlkZW4gYcOnxLFsZMSxLiBCdWfDvG4gVMO8cmtpeWXigJlkZSDigJxwcm9qZSBva3VsbGFy4oCdIGJhxZ9sxLHEn8SxIGFsdMSxbmRhIGZlbiB2ZSBzb3N5YWwgYmlsaW1sZXIsIGRpbCwgc2FuYXQsIHNwb3IgdmUgaGFmxLF6bMSxayBhbGFuxLFuZGFraSBpbWFtIGhhdGlwbGVyaW4geWFuxLFzxLFyYSwgdWx1c2xhcmFyYXPEsSBpbWFtIGhhdGlwbGVyIGRlIGZhYWxpeWV0IGfDtnN0ZXJpeW9yLiBZdXJ0ZMSxxZ/EsW5kYSBpc2UgMjIgw7xsa2VkZSA1NCBpbWFtIGhhdGlwIGxpc2VzaSBidWx1bnV5b3IuPC9wPgoKICAgICAgICAgICAgPC9kaXY+";
      String commisionDetail =
          "w5ZOREVS4oCZaSBUw7xya2l5ZeKAmW5pbiBlbiDDtm5lbWxpIHNpdmlsIHRvcGx1bSBrdXJ1bHXFn3UgaGFsaW5lIGdldGlybWVrIHZlIGZhYWxpeWV0IGFsYW7EsSBpbGUgdWxhxZ9hYmlsZWNlxJ9pIGVuIHXDpyBub2t0YXlhIHVsYcWfbWFrLg==";
      _db = await initilizeDb();
      deleteAll(tblNews);
      deleteAll(tblCommisions);
      deleteAll(tblConnection);
      deleteAll(tblSwiper);
      deleteAll(tblStablePages);
      var result = await _db.rawQuery('SELECT * FROM News');

      if (result.isEmpty) {
        News announcement = News(text, "DUYURU DENEMESİ", photoNews, "_link",
            "duyuru", "20200226", "20200226");
        News news = News(text, "HABER DENEMESİ", photoNews, "_link", "haber",
            "20200226", "20200226");
        StablePages stbl =
            new StablePages("Tarihçemiz", "/tarihcemiz", tarihce, photoNews);
        SwiperModel swp = new SwiperModel(
            photoNews,
            "BU OKULDAN ALİMLER ÇIKACAK",
            "https://onder.org.tr/tr/Haber/bu-okuldan-alimler-cikacak-hb8ee29",
            "detay");
        Connection_Model merkez = Connection_Model(
            "Akşemsettin Mh. Şair Fuzuli Sk. No: 22 Fatih - İstanbul",
            "ÖNDER Genel Merkez",
            "onder@onder.org.tr",
            "0 (212) 521 19 58",
            1);
        Connection_Model ankara = Connection_Model(
            "Mebusevleri Mah, Ayten Sk. No:21 Çankaya/Ankara",
            "ÖNDER Ankara Temsilciliği",
            "ankara@onder.org.tr",
            "0 (000) 000 00 00",
            2);
        Connection_Model genclik = Connection_Model(
            "Alemdar Mh., Hükümet Konağı Cd. No:7 Fatih/İstanbul",
            "ÖNDER Gençlik",
            "akademi@onder.org.tr",
            "0 (212) 520 00 04",
            3);
        CommisionsModel cm = new CommisionsModel(commisionPhoto,
            "Teşkilatlanma", commisionDetail, "/teskilatlanma", 1);

        insertNews(news);
        insertNews(news);

        insertNews(announcement);
        insertNews(announcement);

        insertSwiper(swp);
        insertSwiper(swp);

        insertStable(stbl);

        insertCommision(cm);

        insertConnection(merkez);
        insertConnection(ankara);
        insertConnection(genclik);
      }
    }
    return _db;
  }

  void _createDb(Database db, int version) async {
    await db.execute("Create table $tblCommisions(" +
        "$colPic text," +
        "$colTitle text," +
        "$colDetails text," +
        "$colLink text," +
        "$colOrder text," +
        "$colId integer primary key autoincrement)");

    await db.execute("Create table $tblConnection($colName text," +
        "$colAdress text," +
        "$colEmail text," +
        "$colGsm text," +
        "$colOrder text," +
        "$colId integer primary key autoincrement)");

    await db.execute("Create table $tblNews($colTitle text," +
        "$colText text," +
        "$colPic text," +
        "$colLink text," +
        "$colCategory text ," +
        "$colDate text," +
        "$colUpdateDate text," +
        "$colId integer primary key autoincrement)");

    await db.execute("Create table $tblStablePages($colName text," +
        "$colLink text," +
        "$colText text," +
        "$colPic text," +
        "$colId integer primary key autoincrement)");

    await db.execute("Create table $tblSwiper($colPic text," +
        "$colTitle text," +
        "$colLink text," +
        "$colDetails text," +
        "$colId integer primary key autoincrement)");
  }

//////////////////////////////////////////////////////////////
  //////////////////////STABLE PAGES///////////////////////
  /////////////////////////////////////////////////////////

  Future<int> insertStable(StablePages stable) async {
    Database db = await this.db;
    var result = await db.insert(tblStablePages, stable.toMap());
    return result;
  }

  Future<int> deleteStable(String link) async {
    Database db = await this.db;
    var result =
        db.rawDelete("delete from $tblStablePages where $colLink = $link");
    return result;
  }

  Future<List> getStable(String link) async {
    Database db = await this.db;
    var result = await db
        .rawQuery("select * from $tblStablePages where link = '/tarihce'");
    return result;
  }

  ////////////CHECK IF EMPTY/////////////
  Future<bool> checkEmpty() async {
    Database db = await this.db;
    var result = await db.rawQuery("Select * from News");
    if (result.isEmpty) {
      return true;
    } else {
      return false;
    }
    ////////////CHECK IF EMPTY/////////////
  }

  Future<List> getStablePagesList() async {
    Database db = await this.db;
    var result = await db.rawQuery("select * from $tblStablePages");
    return result;
  }
//////////////////////////////////////////////////////////////
  //////////////////////STABLE PAGES///////////////////////
  /////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////
  //////////////////////    SWİPER   ///////////////////////
  /////////////////////////////////////////////////////////
  Future<int> insertSwiper(SwiperModel swiper) async {
    Database db = await this.db;
    var result = await db.insert(tblSwiper, swiper.toMap());
    return result;
  }

  Future<int> updateSwiper(SwiperModel swiper) async {
    Database db = await this.db;
    var result = db.update(tblSwiper, swiper.toMap(),
        where: "$colLink=?", whereArgs: [swiper.link]);
    return result;
  }

  //////////////////////////////////////////////////////////////
  //////////////////////    SWİPER   ///////////////////////
  /////////////////////////////////////////////////////////

  /// //////////////////////////////////////////////////////////////
  //////////////////////    Commision   ///////////////////////
  /////////////////////////////////////////////////////////
  ///
  ///
  Future<int> insertCommision(CommisionsModel com) async {
    Database db = await this.db;
    var result = await db.insert(tblCommisions, com.toMap());
    return result;
  }

  ///
  ///
  /// //////////////////////////////////////////////////////////////
  //////////////////////    SWİPER   ///////////////////////
  /////////////////////////////////////////////////////////

  //////////////////////////////////////////////////////////////
  //////////////////////    functions   ///////////////////////
  /////////////////////////////////////////////////////////
  ///
  Future<List> getFunction(String tblName, String link) async {
    Database db = await this.db;
    var result = await db.rawQuery("select *from $colName where link=$link");
    return result;
  }

  Future<List> getAllFunction(String tblName) async {
    Database db = await this.db;
    var result = await db.rawQuery("select *from $tblName");
    return result;
  }

  Future<List> getFromNewsTable(String _category) async {
    Database db = await this.db;
    var result = await db.rawQuery(
        "select * from News where category='$_category' order by $colDate asc");
    return result;
  }

  Future<int> deleteFunction(String tblName, String link) async {
    Database db = await this.db;
    var result = db.rawDelete("delete from $tblName where $colLink = $link");
    return result;
  }

  Future<int> deleteAll(String tblName) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from $tblName");
    return result;
  }

  //////////////////////////////////////////////////////////////
  //////////////////////    functions   ///////////////////////
  /////////////////////////////////////////////////////////
  Future<int> insertNews(News news) async {
    Database db = await this.db;

    var result = await db.insert(tblNews, news.toMap());
    return result;
  }

  Future<int> updateNews(News news) async {
    Database db = await this.db;
    var result = db.update(tblNews, news.toMap(),
        where: "$colLink=?", whereArgs: [news.link]);
    return result;
  }

  Future<int> insertConnection(Connection_Model cm) async {
    Database db = await this.db;

    var result = await db.insert(tblConnection, cm.toMap());
    return result;
  }
}
