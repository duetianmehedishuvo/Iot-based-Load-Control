
class HelplineNumberController  {

  static final List<HelplineModel> allHelplinesData=[
    HelplineModel("জরুরী সেবা","999"),
    HelplineModel("শিশু সহায়তা","1098"),
    HelplineModel("নারী ও শিশু নির্যাতন","109"),
    HelplineModel("জাতীয় পরিচয়পত্র","105"),
    HelplineModel("সরকারী আইন সেবা","16430"),
    HelplineModel("দুর্যোগের আগাম বার্তা","10941"),
    HelplineModel("দুদক হটলাইন","106"),
    HelplineModel("তথ্য সেবা","333"),
    HelplineModel("Police Headquarters 1","01769690019"),
    HelplineModel("Police Headquarters 2","01320001435"),
    HelplineModel("RAB HQ Any information from all over the country","88-02-8961105"),
    HelplineModel("RAB HQ Director General","01777720000"),
    HelplineModel("RAB-01 Gulshan, Badda, Cantonment, Airport & Uttara Thana Thanas","02-8963419"),
    HelplineModel("RAB-02 Ramna, Dhanmondi, Lalbagh, Kotowali, Hazaribagh, Kamrangirchor Thana Thanas","02-8363764"),
    HelplineModel("RAB-03 Sutrapur, Motijheel, Demra, Khilgaon, Shampur & Sabujbagh and Sylhet city Thanas.","02-7174687"),
  ];

}

class HelplineModel {
  String title;
  String number;

  HelplineModel(this.title, this.number);
}
