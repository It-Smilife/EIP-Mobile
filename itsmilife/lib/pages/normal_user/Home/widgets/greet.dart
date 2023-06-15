import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itsmilife/constants.dart';
import 'package:itsmilife/pages/common/profile.dart';
import 'package:itsmilife/pages/normal_user/Home/bloc/home_bloc.dart';
import 'package:itsmilife/pages/normal_user/Home/widgets/notification_icon.dart';

class Greet extends StatelessWidget {
  const Greet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Text(
              'Bonjour, ${ProfileData.username}! ${state.mood}',
              style: greetText,
            );
          },
        ),
        NotificationIcon(),
      ],
    );
    
  }
}
