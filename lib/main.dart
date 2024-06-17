import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Calculator',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String myAge = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        toolbarHeight: 70,

        title: const Text("A G E   C A L C U L A T O R",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green,

        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColorDark),
      ),
      
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Your DOB',

              // style: Theme.of(context).textTheme.displayLarge,
              style: TextStyle(fontSize: 60,color: Colors.grey),
            ),

            const SizedBox(
              height: 5,
            ),
            Text(myAge),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () => pickDob(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.green, // Text color of the button
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Button padding
                textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold), // Text size
              ),
              child: const Text('Pick Date of Birth'),
            )
          ],
        ),
      ),
    );
  }


  pickDob(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Header background color
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Selection color
              onPrimary: Colors.black, // Selected text color
              surface: Colors.black, // Background color of date picker dialog
              onSurface: Colors.white, // Text color
            ),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Button text color
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate != null) {
        calculateAge(pickedDate);
      }
    });
  }

  calculateAge(DateTime birth) {
    DateTime now = DateTime.now();
    Duration age = now.difference(birth);
    int years = age.inDays ~/ 365;
    int months = (age.inDays % 365) ~/ 30;
    int days = ((age.inDays % 365) % 30);
    setState(() {
      myAge = '$years years, $months months, and $days days';
    });
  }
}