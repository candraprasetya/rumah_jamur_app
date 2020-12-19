part of '../screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController kodeController = TextEditingController();
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Warna.white,
        body: FutureBuilder<UserModel>(
          future: UserServices.getUser(Get.arguments),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.hasError) {
              return ErrorScreen();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return SpinCircleBottomBarHolder(
                  bottomNavigationBar: SCBottomBarDetails(
                      circleColors: [
                        Warna.gainsboro,
                        Warna.rosyBrown,
                        Warna.primary
                      ],
                      iconTheme: IconThemeData(color: Warna.gainsboro),
                      activeIconTheme: IconThemeData(color: Warna.primary),
                      backgroundColor: Warna.white,
                      titleStyle:
                          TextStyle(color: Warna.gainsboro, fontSize: 12),
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
                              Get.toNamed('/code', arguments: snapshot.data);
                            }),
                        SCItem(
                            icon:
                                Icon(Icons.qr_code_scanner, color: Warna.gray),
                            onPressed: () async {
                              await Permission.camera.request();
                              String code = await scanner.scan();
                              Get.dialog(
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaY: 18, sigmaX: 18),
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(Warna.primary),
                                    ).centered(),
                                  ),
                                  barrierColor: Warna.white.withOpacity(.2),
                                  barrierDismissible: false,
                                  transitionCurve: Curves.easeOutQuint);
                              bool presensi =
                                  await PresensiService.checkPresensi(code);
                              if (!code.isEmptyOrNull) {
                                Get.back();
                              }
                              if (!presensi) {
                                Get.back();
                                Get.snackbar('Gagal Presensi',
                                    'Kode yang anda masukkan salah');
                              } else {
                                await PresensiService.userPresensi(
                                    code, snapshot.data);
                                Get.offAllNamed('/success',
                                    arguments: ['', snapshot.data, code]);
                              }
                            }),
                      ],
                      bnbHeight: 80),
                  child: SafeArea(
                      child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController,
                    onPageChanged: (value) {
                      print(value);
                    },
                    children: [
                      DashBoardScreen(model: snapshot.data),
                      ProfileScreen(
                        user: snapshot.data,
                      ),
                    ],
                  )));
            }

            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Warna.primary),
            ).centered();
          },
        ));
  }
}
