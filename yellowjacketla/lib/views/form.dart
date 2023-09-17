import 'package:flutter/material.dart';


class CrimePredictionForm extends StatefulWidget {
  @override
  _CrimePredictionFormState createState() => _CrimePredictionFormState();
}

class _CrimePredictionFormState extends State<CrimePredictionForm> {
  final _formKey = GlobalKey<FormState>();

  // Variables to store user inputs
  DateTime? _dateOccurred;
  TimeOfDay? _timeOccurred;
  String? _areaID;
  String? _premiseCode;
  String? _victimAge;
  String? _victimSex;
  String? _victimDescent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('See Crime Precitions'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Date Occurred
                TextButton(
                  onPressed: () async {
                    _dateOccurred = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    setState(() {});
                  },
                  child: Text(
                      _dateOccurred == null
                          ? 'Select Date Occurred'
                          : 'Date: ${_dateOccurred!.toLocal().toIso8601String().split('T')[0]}'),
                ),

                // Time Occurred
                TextButton(
                  onPressed: () async {
                    _timeOccurred = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {});
                  },
                  child: Text(
                      _timeOccurred == null ? 'Select Time Occurred' : 'Time: ${_timeOccurred!.format(context)}'),
                ),

                // Other fields
                TextFormField(
                  decoration: InputDecoration(labelText: 'Area ID'),
                  onSaved: (value) => _areaID = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Premise Code'),
                  onSaved: (value) => _premiseCode = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Victim Age'),
                  onSaved: (value) => _victimAge = value,
                ),
                DropdownButtonFormField(
                  hint: Text('Select Victim Sex'),
                  items: ['Male', 'Female', 'Other']
                      .map((sex) => DropdownMenuItem(child: Text(sex), value: sex))
                      .toList(),
                  onChanged: (value) => setState(() => _victimSex = value as String?),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Victim Descent'),
                  onSaved: (value) => _victimDescent = value,
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle the data, perhaps send it to an API or save to local storage
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
