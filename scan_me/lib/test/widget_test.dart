import 'package:flutter/material.dart';
import "package:flutter_test/flutter_test.dart";
import 'package:scan_me/sign_in.dart';
import 'package:scan_me/sign_up.dart';

void main() {
  testWidgets("SignIn: Password must needed", (WidgetTester tester) async{
    final signinPassword = find.byKey(ValueKey("signin_password"));
    final signinSubmit = find.byKey(ValueKey("signin_submit"));

    await tester.pumpWidget(MaterialApp(home: SignIn()));
    await tester.enterText(signinPassword, "Password1");
    await tester.tap(signinSubmit);
    await tester.pump();

    expect(find.text("Password1"),findsOneWidget);
  });

  testWidgets("SignIn: Email must needed", (WidgetTester tester) async{
    final signinEmail = find.byKey(ValueKey("signin_email"));
    final signinSubmit = find.byKey(ValueKey("signin_submit"));

    await tester.pumpWidget(MaterialApp(home: SignIn()));
    await tester.enterText(signinEmail, "random@email.com");
    await tester.tap(signinSubmit);
    await tester.pump();

    expect(find.text("random@email.com"),findsOneWidget);
  });

  testWidgets("SignUP: Username must needed", (WidgetTester tester) async{
    final signinEmail = find.byKey(ValueKey("signup_username"));
    final signinSubmit = find.byKey(ValueKey("signup_submit"));

    await tester.pumpWidget(MaterialApp(home: SignUp()));
    await tester.enterText(signinEmail, "username");
    await tester.tap(signinSubmit);
    await tester.pump();

    expect(find.text("username"),findsOneWidget);
  });

  testWidgets("SignUP: Password must needed", (WidgetTester tester) async{
    final signinEmail = find.byKey(ValueKey("signup_password"));
    final signinSubmit = find.byKey(ValueKey("signup_submit"));

    await tester.pumpWidget(MaterialApp(home: SignUp()));
    await tester.enterText(signinEmail, "Password1");
    await tester.tap(signinSubmit);
    await tester.pump();

    expect(find.text("Password1"),findsOneWidget);
  });

  testWidgets("SignUp: Email must needed", (WidgetTester tester) async{
    final signinEmail = find.byKey(ValueKey("signup_email"));
    final signinSubmit = find.byKey(ValueKey("signup_submit"));

    await tester.pumpWidget(MaterialApp(home: SignUp()));
    await tester.enterText(signinEmail, "random@email.com");
    await tester.tap(signinSubmit);
    await tester.pump();

    expect(find.text("random@email.com"),findsOneWidget);
  });
}