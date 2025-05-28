part of '../navigation_layout.dart';

///
final class _NavigationLayoutHeaderUserButtonMenu extends StatelessWidget {
  ///
  const _NavigationLayoutHeaderUserButtonMenu();

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 50;
    const double width = 220;

    return SizedBox(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: ColoredBox(
          color: Colors.red,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                constraints: const BoxConstraints(maxHeight: headerHeight),
                decoration: BoxDecoration(
                  color: Colors.green,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(blurRadius: 5),
                  ],
                ),

                // Header Section
                child: Row(
                  children: <Widget>[
                    // User icon
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              child: Icon(
                                color: Colors.red,
                                Icons.person_outline,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Contact data
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // Name
                            Text(
                              'Name Here',
                              style: TextStyle(),
                            ),
                            // Email
                            Text(
                              'email',
                              style: TextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // User menu Section
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
