import 'package:discord_clone/screens/call/call_screen.dart';
import 'package:discord_clone/screens/call/prepare_call.dart';
import 'package:discord_clone/screens/chat/chat_screen.dart';
import 'package:discord_clone/screens/home/home_screen.dart';
import 'package:discord_clone/screens/signin/signin_screen.dart';
import 'package:discord_clone/screens/welcome/welcome_screen.dart';
import 'package:discord_clone/screens/channel/channel_screen.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class TestDiscordClone {
  static void run() {
    testWidgets('log in button test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const WelcomeScreen(),
          navigatorObservers: [mockObserver],
        ),
      );
      final finder = find.widgetWithText(ElevatedButton, 'Đăng nhập');
      final widget = tester.firstWidget(finder) as ElevatedButton;
      final states = <MaterialState>{};
      final bgColor = widget.style?.backgroundColor?.resolve(states);
      expect(bgColor, welcomeLoginButtonColor);
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.byType(SigninScreen), findsOneWidget);
      expect(find.text('Chào mừng trở lại!'), findsOneWidget);
    });

    testWidgets('log in to app test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const SigninScreen(),
          navigatorObservers: [mockObserver],
        ),
      );
      final textfield1 =
          find.widgetWithText(TextField, 'Email hoặc Số Điện Thoại');
      await tester.enterText(textfield1, 'admin');
      final textfield2 = find.widgetWithText(TextField, 'Mật khẩu');
      await tester.enterText(textfield2, '1234');
      final finder = find.widgetWithText(ElevatedButton, 'Đăng nhập');
      await tester.tap(finder);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Friends'), findsOneWidget);
    });

    testWidgets('fill text on chat field', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const HomeScreen(),
          navigatorObservers: [mockObserver],
        ),
      );
      final textfield = find.byType(TextField);
      await tester.enterText(textfield, 'hi!');
      final sendButton = find.widgetWithIcon(IconButton, Icons.send);
      await tester.tap(sendButton);
      await tester.pump();
      expect(find.text('hi!'), findsOneWidget);
    });

    testWidgets('reveal chat channel test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const HomeScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final listChannelButton = find.widgetWithIcon(IconButton, Icons.menu);
      await tester.tap(listChannelButton);
      await tester.pumpAndSettle();
      expect(find.byType(ChannelScreen), findsOneWidget);

      final channel = find.widgetWithText(ExpansionTile, 'KÊNH CHAT').last;
      await tester.tap(channel);
      await tester.pump(const Duration(milliseconds: 1000));

      const key = Key('expansionTileChannel5');
      final chatChannel = find.byKey(key);

      await tester.tap(chatChannel);
      await tester.pumpAndSettle();
      expect(find.byType(ChatScreen), findsOneWidget);
      expect(find.text('#kênh-công-chúa'), findsOneWidget);
    });

    testWidgets('call channel test', (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const HomeScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final listChannelButton = find.widgetWithIcon(IconButton, Icons.menu);
      await tester.tap(listChannelButton);
      await tester.pumpAndSettle();
      expect(find.byType(ChannelScreen), findsOneWidget);

      final channel = find.widgetWithText(ExpansionTile, 'KÊNH CHAT').last;
      await tester.tap(channel);
      await tester.pump(const Duration(milliseconds: 1000));

      const key = Key('expansionTileCall5');
      final callChannel = find.byKey(key);

      // final chatChannel = find.widgetWithText(ChannelItemWidget, 'Phòng chờ');
      await tester.tap(callChannel);
      await tester.pumpAndSettle();
      expect(find.byType(PrepareCallScreen), findsOneWidget);
      expect(find.text('Chưa có ai ở đây cả'), findsOneWidget);

      final gobackButton =
          find.widgetWithIcon(ElevatedButton, Icons.expand_more);
      await tester.tap(gobackButton);
      await tester.pumpAndSettle();
      expect(find.byType(ChannelScreen), findsOneWidget);
      expect(find.text('J2Team'), findsOneWidget);
    });

    testWidgets('call button in prepare call screen test',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: const PrepareCallScreen(),
          navigatorObservers: [mockObserver],
        ),
      );

      final callButton = find.widgetWithText(ElevatedButton, 'Tham gia');
      await tester.tap(callButton);
      await tester.pumpAndSettle();
      expect(find.byType(CallScreen), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
    });
  }
}

void main() {
  TestDiscordClone.run();
}
