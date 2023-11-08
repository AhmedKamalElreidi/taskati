import 'package:flutter/material.dart';
import 'package:taskati/core/utils/styles.dart';

class EmptyTaskWidget extends StatelessWidget {
  const EmptyTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/empty.png'),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You do not have any tasks yet!\nAdd new tasks to make your days productive.',
            style: getSmallTextStyle(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
