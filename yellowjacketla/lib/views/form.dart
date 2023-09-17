import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:tflite_flutter/tflite_flutter.dart';



class CrimePredictionForm extends StatefulWidget {
  @override
  _CrimePredictionFormState createState() => _CrimePredictionFormState();
}

class _CrimePredictionFormState extends State<CrimePredictionForm> {
  // late Location location;
  // LocationData? currentLocation;
  final _formKey = GlobalKey<FormState>();
  final List<String> columnNames = ['Desc_A', 'Desc_B', 'Desc_H', 'Desc_W'];
  int result = 0;

  final Map<String, String> columnToDescriptionMapping = {
    'Desc_A': 'Asians',
    'Desc_B': 'Black',
    'Desc_H': 'Hispanic',
    'Desc_W': 'American',
  };

  double? floatTime;
  

  final List<String> sexColumnNames = ['Sex_M', 'Sex_F', 'Sex_X'];

  final Map<String, String> sexToDescriptionMapping = {
    'Sex_M': 'Male',
    'Sex_F': 'Female',
    'Sex_X': 'Other',
  };

  // Variables to store user inputs
  String? _victimAge;
  String? _victimSex;
  String? _victimDescent;

  

  double convertTimeToFloat(TimeOfDay time) {
    return time.hour + time.minute / 60.0;
  }

  @override
  void initState() {
    super.initState();
    var timeOfDay = TimeOfDay.fromDateTime(DateTime.now());
    floatTime = convertTimeToFloat(timeOfDay);
    //location = new Location();
  }
  // Future<void> _requestPermission() async {
  //   if (await Permission.location.request().isGranted) {
  //     _getLocation();
  //   }
  // }

  // Future<void> _getLocation() async {
  //   try {
  //     currentLocation = await location.getLocation();
  //     setState(() {});
  //   } catch (e) {
  //     print("Error getting location: $e");
  //   }
  // }

  final Map<String, dynamic> columnValues = {
    'TIME OCC': 0.0,
    'AREA': 15.0,
    'Vict Age': 90.0,
    'LAT':  34.01971581677867,
    'LON':  -118.28945110196433,
    'Crm Cd': 500.0,      
    'Sex_F': 0.0,
    'Sex_H': 0.0,    
    'Sex_M':  0.0,   
    'Sex_X': 0.0,
    'Desc_-': 0.0,
    'Desc_A': 0.0,
    'Desc_B': 0.0,
    'Desc_C': 0.0,
    'Desc_D': 0.0,
    'Desc_F': 0.0,
    'Desc_G': 0.0,
    'Desc_H': 0.0,
    'Desc_I': 0.0,
    'Desc_J': 0.0,
    'Desc_K': 0.0,
    'Desc_L': 0.0,
    'Desc_O': 0.0,
    'Desc_P': 0.0,
    'Desc_S': 0.0,
    'Desc_U': 0.0,
    'Desc_V': 0.0,
    'Desc_W': 0.0,
    'Desc_X': 0.0,
    'Desc_Z': 0.0,
  };

  Map<int,String> mapping_crime_Desc = {624: 'BATTERY - SIMPLE ASSAULT',
 845: 'SEX OFFENDER REGISTRANT OUT OF COMPLIANCE',
 745: 'VANDALISM - MISDEAMEANOR (399 OR UNDER)',
 740: 'VANDALISM - FELONY (400 & OVER, ALL CHURCH VANDALISMS)',
 121: 'RAPE, FORCIBLE',
 442: 'SHOPLIFTING - PETTY THEFT (950 & UNDER)',
 946: 'OTHER MISCELLANEOUS CRIME',
 341: 'THEFT-GRAND (950.01 & OVER)EXCPT,GUNS,FOWL,LIVESTK,PROD',
 330: 'BURGLARY FROM VEHICLE',
 930: 'CRIMINAL THREATS - NO WEAPON DISPLAYED',
 648: 'ARSON',
 626: 'INTIMATE PARTNER - SIMPLE ASSAULT',
 440: 'THEFT PLAIN - PETTY (950 & UNDER)',
 354: 'THEFT OF IDENTITY',
 210: 'ROBBERY',
 230: 'ASSAULT WITH DEADLY WEAPON, AGGRAVATED ASSAULT',
 310: 'BURGLARY',
 510: 'VEHICLE - STOLEN',
 420: 'THEFT FROM MOTOR VEHICLE - PETTY (950 & UNDER)',
 761: 'BRANDISH WEAPON',
 236: 'INTIMATE PARTNER - AGGRAVATED ASSAULT',
 662: 'BUNCO, GRAND THEFT',
 350: 'THEFT, PERSON',
 860: 'BATTERY WITH SEXUAL CONTACT',
 480: 'BIKE - STOLEN',
 623: 'BATTERY POLICE (SIMPLE)',
 956: 'LETTERS, LEWD  -  TELEPHONE CALLS, LEWD',
 900: 'VIOLATION OF COURT ORDER',
 888: 'TRESPASSING',
 331: 'THEFT FROM MOTOR VEHICLE - GRAND (950.01 AND OVER)',
 901: 'VIOLATION OF RESTRAINING ORDER',
 886: 'DISTURBING THE PEACE',
 421: 'THEFT FROM MOTOR VEHICLE - ATTEMPT',
 647: 'THROWING OBJECT AT MOVING VEHICLE',
 940: 'EXTORTION',
 810: 'SEX,UNLAWFUL(INC MUTUAL CONSENT, PENETRATION W/ FRGN OBJ',
 922: 'CHILD STEALING',
 812: 'CRM AGNST CHLD (13 OR UNDER) (14-15 & SUSP 10 YRS OLDER)',
 220: 'ATTEMPTED ROBBERY',
 625: 'OTHER ASSAULT',
 755: 'BOMB SCARE',
 649: 'DOCUMENT FORGERY / STOLEN FELONY',
 815: 'SEXUAL PENETRATION W/FOREIGN OBJECT',
 251: 'SHOTS FIRED AT INHABITED DWELLING',
 320: 'BURGLARY, ATTEMPTED',
 890: 'FAILURE TO YIELD',
 850: 'INDECENT EXPOSURE',
 820: 'ORAL COPULATION',
 668: 'EMBEZZLEMENT, GRAND THEFT (950.01 & OVER)',
 902: 'VIOLATION OF TEMPORARY RESTRAINING ORDER',
 664: 'BUNCO, PETTY THEFT',
 920: 'KIDNAPPING - GRAND ATTEMPT',
 343: 'SHOPLIFTING-GRAND THEFT (950.01 & OVER)',
 437: 'RESISTING ARREST',
 753: 'DISCHARGE FIREARMS/SHOTS FIRED',
 928: 'THREATENING PHONE CALLS/LETTERS',
 910: 'KIDNAPPING',
 760: 'LEWD/LASCIVIOUS ACTS WITH CHILD',
 762: 'LEWD CONDUCT',
 661: 'UNAUTHORIZED COMPUTER ACCESS',
 351: 'PURSE SNATCHING',
 821: 'SODOMY/SEXUAL CONTACT B/W PENIS OF ONE PERS TO ANUS OTH',
 237: 'CHILD NEGLECT (SEE 300 W.I.C.)',
 903: 'CONTEMPT OF COURT',
 813: 'CHILD ANNOYING (17YRS & UNDER)',
 666: 'BUNCO, ATTEMPT',
 627: 'CHILD ABUSE (PHYSICAL) - SIMPLE ASSAULT',
 805: 'PIMPING',
 763: 'STALKING',
 441: 'THEFT PLAIN - ATTEMPT',
 122: 'RAPE, ATTEMPTED',
 443: 'SHOPLIFTING - ATTEMPT',
 450: 'THEFT FROM PERSON - ATTEMPT',
 520: 'VEHICLE - ATTEMPT STOLEN',
 434: 'FALSE IMPRISONMENT',
 410: 'BURGLARY FROM VEHICLE, ATTEMPTED',
 670: 'EMBEZZLEMENT, PETTY THEFT (950 & UNDER)',
 951: 'DEFRAUDING INNKEEPER/THEFT OF SERVICES, 950 & UNDER',
 660: 'COUNTERFEIT',
 654: 'CREDIT CARDS, FRAUD USE (950 & UNDER',
 352: 'PICKPOCKET',
 250: 'SHOTS FIRED AT MOVING VEHICLE, TRAIN OR AIRCRAFT',
 110: 'CRIMINAL HOMICIDE',
 652: 'DOCUMENT WORTHLESS (200 & UNDER)',
 933: 'PROWLER',
 950: 'DEFRAUDING INNKEEPER/THEFT OF SERVICES, OVER 950.01',
 231: 'ASSAULT WITH DEADLY WEAPON ON POLICE OFFICER',
 345: 'DISHONEST EMPLOYEE - GRAND THEFT',
 822: 'HUMAN TRAFFICKING - COMMERCIAL SEX ACTS',
 814: 'CHILD PORNOGRAPHY',
 932: 'PEEPING TOM',
 622: 'BATTERY ON A FIREFIGHTER',
 471: 'TILL TAP - PETTY (950 & UNDER)',
 235: 'CHILD ABUSE (PHYSICAL) - AGGRAVATED ASSAULT',
 470: 'TILL TAP - GRAND THEFT (950.01 & OVER)',
 921: 'HUMAN TRAFFICKING - INVOLUNTARY SERVITUDE',
 906: 'FIREARMS RESTRAINING ORDER (FIREARMS RO)',
 433: 'DRIVING WITHOUT OWNER CONSENT (DWOC)',
 651: 'DOCUMENT WORTHLESS (200.01 & OVER)',
 806: 'PANDERING',
 943: 'CRUELTY TO ANIMALS',
 653: 'CREDIT CARDS, FRAUD USE (950.01 & OVER)',
 436: 'LYNCHING - ATTEMPTED',
 949: 'ILLEGAL DUMPING',
 446: 'PETTY THEFT - AUTO REPAIR',
 113: 'MANSLAUGHTER, NEGLIGENT',
 487: 'BOAT - STOLEN',
 438: 'RECKLESS DRIVING',
 451: 'PURSE SNATCHING - ATTEMPT',
 439: 'FALSE POLICE REPORT',
 485: 'BIKE - ATTEMPTED STOLEN',
 944: 'CONSPIRACY',
 954: 'CONTRIBUTING',
 756: 'WEAPONS POSSESSION/BOMBING',
 942: 'BRIBERY',
 473: 'THEFT, COIN MACHINE - GRAND (950.01 & OVER)',
 347: 'GRAND THEFT / INSURANCE FRAUD',
 435: 'LYNCHING',
 880: 'DISRUPT SCHOOL',
 444: 'DISHONEST EMPLOYEE - PETTY THEFT',
 475: 'THEFT, COIN MACHINE - ATTEMPT',
 474: 'THEFT, COIN MACHINE - PETTY (950 & UNDER)',
 931: 'REPLICA FIREARMS(SALE,DISPLAY,MANUFACTURE OR DISTRIBUTE)',
 865: 'DRUGS, TO A MINOR',
 349: 'GRAND THEFT / AUTO REPAIR',
 353: 'DRUNK ROLL',
 452: 'PICKPOCKET, ATTEMPT',
 870: 'CHILD ABANDONMENT',
 522: 'VEHICLE, STOLEN - OTHER (MOTORIZED SCOOTERS, BIKES, ETC)',
 924: 'TELEPHONE PROPERTY - DAMAGE',
 840: 'BEASTIALITY, CRIME AGAINST NATURE SEXUAL ASSLT WITH ANIM',
 948: 'BIGAMY',
 884: 'FAILURE TO DISPERSE',
 904: 'FIREARMS EMERGENCY PROTECTIVE ORDER (FIREARMS EPO)',
 830: 'INCEST (SEXUAL ACTS BETWEEN BLOOD RELATIVES)',
 445: 'DISHONEST EMPLOYEE ATTEMPTED THEFT',
 432: 'BLOCKING DOOR INDUCTION CENTER',
 882: 'INCITING A RIOT'};

Future<void> predData() async {
    final interpreter =
      await Interpreter.fromAsset('converted_model.tflite');
      var sexColumns = ['Sex_F', 'Sex_M', 'Sex_X'];
      var descColumns = ['Desc_-', 'Desc_A', 'Desc_B', 'Desc_C', 'Desc_D', 'Desc_F', 'Desc_G', 'Desc_H', 'Desc_I', 'Desc_J', 'Desc_K', 'Desc_L', 'Desc_O', 'Desc_P', 'Desc_S', 'Desc_U', 'Desc_V', 'Desc_W', 'Desc_X', 'Desc_Z'];

      for (var column in sexColumns) {
        columnValues[column] = column == _victimSex ? 1.0 : 0.0; // Assign as float
      }

      for (var column in descColumns) {
        columnValues[column] = column == _victimDescent ? 1.0 : 0.0; // Assign as float
      }

      columnValues['Vict Age'] = double.tryParse(_victimAge!) ?? 0.0;
      var input = [columnValues.values.toList()];
      var output = List.filled(1, 0).reshape([1, 1]);
      interpreter.run(input, output);
      result = (output[0][0]).toInt();
      setState(() {
        
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Predict Crimes',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ]),
            child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Age'),
                      onSaved: (value) => _victimAge = value,
                    ),
                    DropdownButtonFormField<String>(
                      value: _victimSex,
                      hint: Text('Select your sex'),
                      items: sexColumnNames.map((column) {
                        return DropdownMenuItem<String>(
                          value: column,
                          child: Text(sexToDescriptionMapping[column]!),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _victimSex = value),
                    ),
                    DropdownButtonFormField<String>(
                      value: _victimDescent,
                      hint: Text('Select Your Descent'),
                      items: columnNames.map((column) {
                        return DropdownMenuItem<String>(
                          value: column,
                          child: Text(columnToDescriptionMapping[column]!),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _victimDescent = value),
                    ),
          
                    Center(
                      child: ElevatedButton(
                        child: Text('Submit',
                        style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            predData();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
                ),
          ),
          SizedBox(height: 20,),
        result!=0?
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            'There are high chances of the following to happen in your area - ${mapping_crime_Desc[result]}',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Poppins'
            ),
          ),
        )
        :Container()
        ],),
      )
    );
  }
}
