import 'package:flutter/material.dart';

class Downloaded extends StatelessWidget {
  const Downloaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Downloaded')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Cover letter has been downloaded.',
              style: Theme.of(context).textTheme.headline2,
            ),
            const Spacer(),
            Image.asset('assets/images/coverletter.png'),
            const Spacer(),
            MaterialButton(
              color: const Color(0xFF0652DD),
              onPressed: () {},
              disabledColor: Colors.grey.shade200,
              disabledTextColor: Colors.black,
              child: Text(
                'View cover letter',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
