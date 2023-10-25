import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itsmilife/constants.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/common/settings/RoleProvider.dart';
import 'package:itsmilife/pages/normal_user/Home/bloc/home_bloc.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/notification_icon.dart';
import 'package:provider/provider.dart';

class Greet extends StatelessWidget {
  const Greet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<RoleProvider>(context);
    final role = user.Setrolestate ? ProfileData.firstName : ProfileData.lastName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Text(
              'Bonjour, $role ! ${state.mood}',
              style: greetText,
            );
          },
        ),
        NotificationIcon(),
      ],
    );
  }
}
