import 'package:example/components/landing_component.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final ValueNotifier<Widget> selectedWidget = ValueNotifier<Widget>(LandingComponent());

final class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawerEnableOpenDragGesture: true,
        drawer: Container(
          color: Colors.blueGrey,
          width: MediaQuery.sizeOf(context).width * .5,
          child: Column(
            children: [
              _ComponentViewButton(
                name: 'Home',
                component: Text(''),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('TWS Foundation View Landing'),
        ),
        body: ValueListenableBuilder(
          valueListenable: selectedWidget,
          builder: (context, value, child) {
            return value;
          },
        ),
      ),
    );
  }
}

final class _ComponentViewButton extends StatelessWidget {
  final String name;
  final Widget component;

  const _ComponentViewButton({
    required this.name,
    required this.component,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        left: 12,
        right: 12,
      ),
      child: SizedBox(),
    );
  }
}
