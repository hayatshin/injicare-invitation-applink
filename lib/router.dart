import 'package:go_router/go_router.dart';
import 'package:injicare_invitation_applink/main.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InvitationHome(
        sendUserId: "",
        sendUserName: "-",
      ),
    ),
    GoRoute(
      path: '/:sendUserId/:sendUserName',
      builder: (context, state) {
        final sendUserId = state.pathParameters["sendUserId"].toString();
        final sendUserName = state.pathParameters["sendUserName"].toString();
        return InvitationHome(
          sendUserId: sendUserId,
          sendUserName: sendUserName,
        );
      },
    )
  ],
);
