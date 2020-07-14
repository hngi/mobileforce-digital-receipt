class Currency {
  final int id;
  final String flag;
  final String currencyName;
  final String currencySymbol;

  Currency({this.id,this.currencyName,this.currencySymbol,this.flag});

  static List<Currency> currencyList(){ 
    return <Currency>[
      Currency(id:1,currencyName:'Naira',currencySymbol:'₦',flag:'🇳🇬', ),
      Currency(id:2,currencyName:'USD',currencySymbol:'\$', flag:'🇺🇸', ),
      Currency(id:3,currencyName:'Cedi',currencySymbol:'₵',flag:'🇬🇭', ),
      Currency(id:1,currencyName:'rupee',currencySymbol:'₦',flag:'🇳🇬', ),
      Currency(id:1,currencyName:'Naira',currencySymbol:'₦',flag:'🇳🇬', ),
      Currency(id:1,currencyName:'Naira',currencySymbol:'₦',flag:'🇳🇬', ),
      Currency(id:1,currencyName:'Naira',currencySymbol:'₦',flag:'🇳🇬', ),
      Currency(id:1,currencyName:'Naira',currencySymbol:'₦',flag:'🇳🇬', ),
    ];
  }
}