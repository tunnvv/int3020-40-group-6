import 'package:discord_clone/screens/call/call_screen.dart';
import 'package:discord_clone/screens/channel/channel_screen.dart';
import 'package:discord_clone/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PrepareCallScreen extends StatefulWidget {
  const PrepareCallScreen({Key? key}) : super(key: key);

  @override
  State<PrepareCallScreen> createState() => _PrepareCallScreenState();
}

class _PrepareCallScreenState extends State<PrepareCallScreen> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(15.0),
      topRight: Radius.circular(15.0),
    );
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(ChannelScreenPageRoute());
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: kSigninBntColor, shape: const CircleBorder()),
          child: const Icon(
            Icons.expand_more,
            size: 26,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: const <Widget>[
            Icon(
              Icons.volume_up,
              color: kPrimaryLightColor,
            ),
            Text(
              " Chat",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kPrimaryLightColor),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: kSigninBntColor, shape: const CircleBorder()),
            child: const Icon(
              Icons.person_add,
              size: 26,
              color: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: kSigninBntColor, shape: const CircleBorder()),
            child: const Icon(
              Icons.chat_bubble,
              size: 26,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 190,
            left: 70,
            right: 65,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: kSigninBntColor,
                  shape: const CircleBorder()),
              child: const Icon(
                Icons.volume_up,
                size: 58,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            top: 250,
            left: 50,
            right: 50,
            child: Text(
              "Ch??a c?? ai ??? ????y c???",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryLightColor),
            ),
          ),
          const Positioned(
            top: 300,
            left: 70,
            right: 65,
            child: Text(
              "K??nh tho???i l?? ????? t??n g???u. Khi b???n ???? s???n s??ng tr?? chuy???n, ch??? c???n nh???y v??o tham gia. B???n b?? c??ng c?? th??? th???y v?? tham gia c??ng b???n. Gi???ng nh?? s??? d???ng th???n giao c??ch c???m ????? ch??o h???i v???y.",
              textAlign: TextAlign.center,
              style: TextStyle(color: kPrimaryLightColor),
            ),
          ),
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            visible: true,
            child: SlidingUpPanel(
              color: kSigninBntColor,
              controller: PanelController(),
              borderRadius: radius,
              panel: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey),
                        child: const Icon(Icons.mic, size: 36),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CallScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: Colors.green),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('Tham gia'),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(
                              Icons.volume_up,
                              size: 40.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChannelScreenPageRoute extends PageRouteBuilder {
  ChannelScreenPageRoute()
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                const PrepareCallScreen());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return SlideTransition(
      position:
          Tween<Offset>(begin: const Offset(.0, .0), end: const Offset(0, 1))
              .animate(controller!),
      child: const ChannelScreen(),
    );
  }
}
