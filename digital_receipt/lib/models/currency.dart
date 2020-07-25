class Currency {
  final int id;
  final String flag;
  final String currencyName;
  final String currencySymbol;

  Currency({this.id,this.currencyName,this.currencySymbol,this.flag});

  static List<Currency> currencyList(){ 
    return <Currency>[
      Currency(id:1,currencyName:'Nigerian Naira',currencySymbol:'₦',flag:'🇳🇬', ),
      Currency(id:2,currencyName:'United States Dollars',currencySymbol:'\$', flag:'🇺🇸', ),
      Currency(id:3,currencyName:'Ghananian Cedi',currencySymbol:'₵',flag:'🇬🇭', ),
      Currency(id:4,currencyName:'Indian rupee',currencySymbol:'₹',flag:'🇮🇳', ),
      Currency(id:5,currencyName:'Great Britain Pounds',currencySymbol:'£',flag:'󠁧󠁢󠁥󠁮🇬🇧', ),
      Currency(id:6,currencyName:'Euro',currencySymbol:'€',flag:'🇻🇦', ),
      Currency(id:7,currencyName:'French Franc',currencySymbol:'₣',flag:'🇫🇷', ),
      Currency(id:8,currencyName:'Japanese Yen',currencySymbol:'¥',flag:'🇯🇵', ),
      Currency(id:9,currencyName:'Isreali shekel',currencySymbol:'₪',flag:'🇮🇱', ),
      Currency(id:10,currencyName:'Spanish peseta',currencySymbol:'₧',flag:'🇪🇸', ),
    ];
  }
  //  List<Currency> currencyList = [
  //     Currency(id:1,currencyName:'Naira',currencySymbol:'₦',flag:'🇳🇬', ),
  //     Currency(id:2,currencyName:'USD',currencySymbol:'\$', flag:'🇺🇸', ),
  //     Currency(id:3,currencyName:'Cedi',currencySymbol:'₵',flag:'🇬🇭', ),
  //     Currency(id:4,currencyName:'rupee',currencySymbol:'₹',flag:'🇮🇴', ),
  //     Currency(id:5,currencyName:'Pounds',currencySymbol:'£',flag:'󠁧󠁢󠁥󠁮🇬🇧', ),
  //     Currency(id:6,currencyName:'Euro',currencySymbol:'€',flag:'🇻🇦', ),
  //     Currency(id:7,currencyName:'Franc',currencySymbol:'₣',flag:'🇫🇷', ),
  //     Currency(id:8,currencyName:'Yen',currencySymbol:'¥',flag:'🇯🇵', ),
  //     Currency(id:9,currencyName:'shekel',currencySymbol:'₪',flag:'🇮🇱', ),
  //     Currency(id:10,currencyName:'peseta',currencySymbol:'₧',flag:'🇪🇸', ),
  //   ];
}

//  List<Currency> currencyList = [
//       Currency(id:1,currencyName:'Naira',currencySymbol:'₦',flag:'🇳🇬', ),
//       Currency(id:2,currencyName:'USD',currencySymbol:'\$', flag:'🇺🇸', ),
//       Currency(id:3,currencyName:'Cedi',currencySymbol:'₵',flag:'🇬🇭', ),
//       Currency(id:4,currencyName:'rupee',currencySymbol:'₹',flag:'🇮🇴', ),
//       Currency(id:5,currencyName:'Pounds',currencySymbol:'£',flag:'󠁧󠁢󠁥󠁮🇬🇧', ),
//       Currency(id:6,currencyName:'Euro',currencySymbol:'€',flag:'🇻🇦', ),
//       Currency(id:7,currencyName:'Franc',currencySymbol:'₣',flag:'🇫🇷', ),
//       Currency(id:8,currencyName:'Yen',currencySymbol:'¥',flag:'🇯🇵', ),
//       Currency(id:9,currencyName:'shekel',currencySymbol:'₪',flag:'🇮🇱', ),
//       Currency(id:10,currencyName:'peseta',currencySymbol:'₧',flag:'🇪🇸', ),
//     ];
