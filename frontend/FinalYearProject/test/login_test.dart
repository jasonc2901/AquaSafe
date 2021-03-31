import 'package:FinalYearProject/CustomDialog/InvalidLoginAlert.dart';
import 'package:FinalYearProject/view/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeWidgetTestable({Widget child}) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(textScaleFactor: 0.5),
        child: child,
      ),
    );
  }

  testWidgets('Test the login screen', (WidgetTester tester) async {
    WelcomePage welcomePage = new WelcomePage();

    await tester.pumpWidget(makeWidgetTestable(child: welcomePage));

    // Create the Finders.
    final pageTitleFinder = find.text('Sign In');
    final textFieldFinder = find.byType(TextFormField);

    // Checks the page has displayed the correct title
    // checks the page contains two Text input fields
    expect(pageTitleFinder, findsOneWidget);
    expect(textFieldFinder, findsNWidgets(2));

    //enter an incorrect test email and test password
    await tester.enterText(
        find.byKey(new Key('emailTextField')), "test123@test.com");

    //refresh the frame on the screen
    await tester.pump();

    await tester.enterText(
        find.byKey(new Key('passwordTextField')), "password123");

    //refresh the frame on the screen
    await tester.pump();

    //test that the entered values are now on screen
    expect(find.text('test123@test.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);

    //press the login button
    expect(find.byKey(Key('loginBtnKey')), findsOneWidget);
    await tester.tap(find.byKey(Key('loginBtnKey')));

    //refresh the frame on screen
    await tester.pump(Duration(milliseconds: 1000));

    //expect false as login is invalid
    assert(welcomePage.signedIn == false);
  });
}
