import 'package:go_router/go_router.dart';
import 'package:injicare_invitation_applink/main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const InvitationHome(
        sendUserId: "",
        sendUserName: "",
      ),
    ),
    GoRoute(
      name: 'user',
      path: '/user',
      builder: (context, state) {
        final sendUserId = state.uri.queryParameters["sendUserId"].toString();
        final sendUserName =
            state.uri.queryParameters["sendUserName"].toString();
        return InvitationHome(
          sendUserId: sendUserId,
          sendUserName: sendUserName,
        );
      },
    )
  ],
);
