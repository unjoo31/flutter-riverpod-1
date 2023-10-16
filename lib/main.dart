import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// 창고 class(상태, 행위)(Provider - 상태만 필요, StateNotifierProvider - 내부 상태 + 메서드 필요)
int num = 1; // Provider - 창고 데이터(상태만 있을 경우 class로 만들 필요는 없다)

// 창고 관리자
final numProvider = Provider<int>((ref) {
  return num;
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MyText1(),
              MyText2(),
              MyText3(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyText3 extends StatelessWidget {
  const MyText3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("없음", style: TextStyle(fontSize: 30));
  }
}

class MyText2 extends ConsumerWidget {
  const MyText2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int num = ref.read(numProvider);
    return Text("${num}", style: TextStyle(fontSize: 30));
  }
}

// 수신(구독하기)
class MyText1 extends ConsumerWidget {
  const MyText1({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetRef ref : 창고 관리자에게 접근가능
    int num = ref.read(numProvider); // 창고 관리자에 접급하기
    return Text("${num}", style: TextStyle(fontSize: 30));
  }
}
