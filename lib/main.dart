import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injicare_invitation_applink/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "NanumSquare",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF2D78),
        ),
        useMaterial3: true,
      ),
      // home: const InvitationHome(
      //   sendUserId: "",
      //   sendUserName: "",
      // ),
    );
  }
}

class InvitationHome extends StatefulWidget {
  final String sendUserId;
  final String sendUserName;
  const InvitationHome({
    super.key,
    required this.sendUserId,
    required this.sendUserName,
  });

  @override
  State<InvitationHome> createState() => _InvitationHomeState();
}

class _InvitationHomeState extends State<InvitationHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  String targetPlatform = "";

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(
      begin: -10,
      end: -5,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  void _launchURL() async {
    try {
      final domain = defaultTargetPlatform == TargetPlatform.macOS ||
              defaultTargetPlatform == TargetPlatform.iOS
          ? "https://apps.apple.com/app/인지케어-ai-치매-예방-솔루션/id6468271503"
          : "https://play.google.com/store/apps/details?id=com.chugnchunon.chungchunon_android&hl=ko-KR";

      setState(() {
        targetPlatform = defaultTargetPlatform.name;
      });
      // final Uri url = Uri.parse(domain);
      // await launchUrl(url);
    } catch (e) {
      // ignore: avoid_print
      print("_launchURL -> $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height - statusBarHeight,
          color: const Color(0xFFFF2D78).withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animation.value),
                      child: Image.asset(
                        "assets/invitation.png",
                      ),
                    );
                  },
                ),
                Flexible(
                  child: Text(
                    widget.sendUserName == ""
                        ? "인지케어에\n초대 받았어요!"
                        : "${widget.sendUserName} 님이\n인지케어에 초대했습니다.",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFFF2D78),
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const Spacer(),
                const Text(
                  "시니어들의 즐거운 소통 시작해볼까요?",
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: _launchURL,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF2D78),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            targetPlatform,
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
