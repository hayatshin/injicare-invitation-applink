import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injicare_invitation_applink/router.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String _domain = "https://hayatshin.github.io/";
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _domain = "https://hayatshin.github.io/${widget.sendUserId}";
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

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(_domain);
    await launchUrl(url);
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
              horizontal: 20,
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
                    "${widget.sendUserName} 님이\n인지케어에 초대했습니다.",
                    style: const TextStyle(
                      fontSize: 16,
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
                    fontSize: 11,
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
                        horizontal: 20,
                        vertical: 18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "다운로드 받기",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            child: SvgPicture.asset(
                              "assets/svg/chevron-right-solid.svg",
                              width: 12,
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
