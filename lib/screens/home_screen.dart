part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController kodeController = TextEditingController();
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Warna.white,
        body: SpinCircleBottomBarHolder(
            bottomNavigationBar: SCBottomBarDetails(
                circleColors: [Warna.gainsboro, Warna.rosyBrown, Warna.primary],
                iconTheme: IconThemeData(color: Warna.gainsboro),
                activeIconTheme: IconThemeData(color: Warna.primary),
                backgroundColor: Warna.white,
                titleStyle: TextStyle(color: Warna.gainsboro, fontSize: 12),
                activeTitleStyle: TextStyle(
                    color: Warna.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                actionButtonDetails: SCActionButtonDetails(
                    color: Warna.gray,
                    icon: Icon(
                      Icons.expand_less,
                      color: Colors.white,
                    ),
                    elevation: 2),
                elevation: 2.0,
                items: [
                  SCBottomBarItem(
                      icon: Icons.dashboard_rounded,
                      title: "Dashboard",
                      onPressed: () {
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOutQuint);
                      }),
                  SCBottomBarItem(
                      icon: Icons.person,
                      title: "Profile",
                      onPressed: () {
                        pageController.animateToPage(1,
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOutQuint);
                      }),
                ],
                circleItems: [
                  SCItem(
                      icon: Icon(
                        Icons.code_rounded,
                        color: Warna.gray,
                      ),
                      onPressed: () {
                        Get.toNamed('/code', arguments: auth.currentUser.uid);
                      }),
                  SCItem(
                      icon: Icon(Icons.qr_code_scanner, color: Warna.gray),
                      onPressed: () {
                        Get.snackbar(
                            "Under Development", "Sedang dikembangkan");
                      }),
                ],
                bnbHeight: 80),
            child: FutureBuilder<UserModel>(
              future: UserServices.getUser(auth.currentUser.uid),
              builder:
                  (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  return SafeArea(
                      child: PageView(
                    controller: pageController,
                    onPageChanged: (value) {
                      print(value);
                    },
                    children: [
                      VxBox(
                        child: VStack(
                          [
                            _title(snapshot.data),
                          ],
                          alignment: MainAxisAlignment.spaceBetween,
                        ),
                      )
                          .size(context.screenWidth, context.screenHeight)
                          .make()
                          .p16(),
                      ProfileScreen().p16(),
                    ],
                  ));
                }

                return CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Warna.primary),
                ).centered();
              },
            )));
  }

  Widget _title(UserModel user) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: 'Rumah',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Warna.primary,
          ),
          children: [
            TextSpan(
              text: 'Jamur',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '\n\nSelamat Datang, ',
              style: TextStyle(
                  color: Vx.gray800, fontSize: 14, fontWeight: FontWeight.w300),
            ),
            TextSpan(
              text: '${user.nama}',
              style: TextStyle(color: Vx.gray800, fontSize: 14),
            ),
          ]),
    );
  }
}
