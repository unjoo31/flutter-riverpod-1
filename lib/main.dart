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

// 창고 데이터 class
class Model {
  int num; // 창고 데이터
  Model(this.num);
}

// 창고 class(상태, 행위)(Provider - 상태만 필요, StateNotifierProvider - 내부 상태 + 메서드 필요)
// Provider - 창고 데이터(상태만 있을 경우 class로 만들 필요는 없다)
class ViewModel extends StateNotifier<Model?> {
  ViewModel(super.state); // state

  // 초기값 설정하는 행위
  void init() {
    // 통신 코드
    state = Model(1);
  }

  // 상태값을 변경하는 행위
  void change() {
    state = Model(2);
  }
}

// 창고 관리자 StateNotifierProvider<창고 이름, 창고 데이터 타입>
final numProvider = StateNotifierProvider<ViewModel, Model?>((ref) {
  // 창고에 접근하기
  return ViewModel(null)..init(); // ..init() : 통신코드를 날린다
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
              MyButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends ConsumerWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref
            .read(numProvider.notifier) // numProvider.notifier : 메서드에 접근하기
            .change();
      },
      child: Text("상태변경"),
    );
  }
}

class MyText3 extends StatelessWidget {
  const MyText3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("5", style: TextStyle(fontSize: 30));
  }
}

class MyText2 extends ConsumerWidget {
  const MyText2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetRef ref : 창고 관리자에게 접근가능
    Model? model = ref.watch(numProvider); // 창고 관리자에 접급하기

    if (model == null) {
      return CircularProgressIndicator();
    } else {
      return Text("${model.num}", style: TextStyle(fontSize: 30));
    }
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
    Model? model = ref.watch(numProvider); // 창고 관리자에 접급하기

    if (model == null) {
      return CircularProgressIndicator();
    } else {
      return Text("${model.num}", style: TextStyle(fontSize: 30));
    }
  }
}
