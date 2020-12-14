part of 'screens.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Warna.white,
        body: FutureBuilder<UserModel>(
          future: UserServices.getUser(auth.currentUser.uid),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return SafeArea(
                      child: VxBox(
                child: VStack(
                  [
                    _title(snapshot.data),
                    MyButton(
                      color: Warna.red,
                      text: 'Keluar',
                      onPress: () {
                        AuthServices.signOut();
                        Get.offAllNamed('/welcome');
                      },
                    )
                  ],
                  alignment: MainAxisAlignment.spaceBetween,
                ),
              ).size(context.screenWidth, context.screenHeight).make())
                  .p12();
            }

            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _title(UserModel user) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
          text: 'Rumah',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Jamur',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: '\nSelamat Datang, ',
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
