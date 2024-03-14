import 'package:flutter/material.dart';
import 'package:scrubster/ui/common/ui_helpers.dart';
import 'package:scrubster/ui/views/aler_widget/aler_widget_view.dart';
import 'package:stacked/stacked.dart';

import 'automaticdata_viewmodel.dart';

class AutomaticdataView extends StackedView<AutomaticdataViewModel> {
  const AutomaticdataView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AutomaticdataViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(
          child: Column(
            children: [
              const Text('Automatic page'),
              verticalSpaceMedium,
              PopScope(
                canPop: false,
                onPopInvoked: (bool value){
                  return viewModel.alertdialog();
                },
                child: TextButton(
                  onPressed:   viewModel.alertdialog,
                  child: const Text('go Back')))
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  AutomaticdataViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AutomaticdataViewModel();
}

// class AlertWidget extends StatelessWidget {
//   const AlertWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Are you sure?'),
//       content: const Text(
//         'Are you sure you want to leave this page?',
//       ),
//       actions: <Widget>[
//         TextButton(
//           style: TextButton.styleFrom(
//             textStyle: Theme.of(context).textTheme.labelLarge,
//           ),
//           child: const Text('Nevermind'),
//           onPressed: () {
//             //pop
//           },
//         ),
//         TextButton(
//           style: TextButton.styleFrom(
//             textStyle: Theme.of(context).textTheme.labelLarge,
//           ),
//           child: const Text('Leave'),
//           onPressed: () {
//             //go to home page and pass value false
//           },
//         ),
//       ],
//     );
//   }
// }
