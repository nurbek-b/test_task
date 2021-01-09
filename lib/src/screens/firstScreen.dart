import 'package:flutter/material.dart';
import 'package:task_flutter_app/src/screens/secondScreen.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool _autoValidate;
  TextEditingController _urlController;
  TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _autoValidate = false;
    _urlController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Url Enter Page'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _buildUrlForm(),
      ),
    );
  }

  Widget _buildUrlForm() {
    return Form(
      key: _key,
      autovalidate: _autoValidate,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /// Image Url fields
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Image URL',
                filled: true,
                isDense: true,
              ),
              controller: _urlController,
              keyboardType: TextInputType.url,
              autocorrect: false,
              validator: _validateUrl,
            ),
            SizedBox(
              height: 12,
            ),
            /// Number field
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Number',
                filled: true,
                isDense: true,
              ),
              controller: _numberController,
              validator: (val) => _validateRequired(val, 'Number'),
            ),
            const SizedBox(
              height: 16,
            ),
            RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(8.0)),
                child: Text('Proceed'),
                onPressed: _validateFormAndProceed),
          ],
        ),
      ),
    );
  }

  String _validateRequired(String val, fieldName) {
    if (val == null ||
        val == '' ||
        !(3 <= int.parse(val) && int.parse(val) < 5)) {
      return '$fieldName is required';
    }
    return null;
  }

  String _validateUrl(String value) {
    if (value == null || value == '') {
      return 'Url is not valid';
    }
    return null;
  }

  void _validateFormAndProceed() {
    // Get form state from the global key
    var formState = _key.currentState;

    // check if form is valid
    if (formState.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            SecondScreen(
              url: _urlController.text,
              number: _numberController.text,)),
      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
