class Countrylist{


  int countryid;
   String countryname;
  String iso;
  String isothree;
  bool ispassport;
  bool isvisa;
  bool isid;
  bool sstatus;
  String updateat;
  String createat;
  int isrighttoworkcountry;

  Countrylist({
      this.countryid,
      this.countryname,
      this.iso,
      this.isothree,
      this.ispassport,
      this.isvisa,
      this.isid,
      this.sstatus,
      this.updateat,
      this.createat,
      this.isrighttoworkcountry});

  factory Countrylist.fromJson(Map<String, dynamic> json) {
    return Countrylist(
      countryid: json['countryid'] as int,
      countryname: json['countryname'] as String,
      updateat: json['updateat'] as String,
      createat: json['createat'] as String,
      isrighttoworkcountry: json['isrighttoworkcountry'] as int,
      isothree: json['isthree'] as String,
      ispassport: json['ispassport'] as bool,
      iso: json['iso'] as String,
      isvisa: json['isvisa'] as bool,
      isid: json['isid'] as bool,
    );
  }
}