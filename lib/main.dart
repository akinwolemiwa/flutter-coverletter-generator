import 'package:coverletter/src/onboarding/views/splash_screen.dart';
import 'package:coverletter/src/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey();
final nav = Navigator.of(navKey.currentContext!);

void main() async {
  //providerscope keeps tracks of the provider
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Coverly',
        builder: (context, child) {
          final query = MediaQuery.of(context);
          final scale = query.textScaleFactor.clamp(1.0, 1.1);

          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            child: child!,
          );
        },
        theme: theme,
        home: const SplashScreen(),
        navigatorKey: navKey,
      ),
    );
  }
}

// this should be like your models.
final counterProvider = StateProvider<int>((ref) {
  return 0;
});

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //this keeps track of changes and rebuid when there is a change to counterProvider
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplicar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$counter', style: textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          ref.read(counterProvider.notifier).update((state) => state + 1);
        }),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
