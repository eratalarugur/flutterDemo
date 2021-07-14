import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.spinnerBackgroundColor,
      child: Center(
        child: SpinKitWave(
          color: Colors.purple,
          size: 50,
        ),
      ),
    );
  }
}
