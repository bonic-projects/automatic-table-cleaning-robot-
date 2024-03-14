import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'aler_widget_viewmodel.dart';

class AlerWidgetView extends StackedView<AlerWidgetViewModel> {
  const AlerWidgetView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AlerWidgetViewModel viewModel,
    Widget? child,
  ) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text(
        'Are you sure you want to leave this page?',
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('No'),
          onPressed: 
            viewModel.popPop
          
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Yes'),
          onPressed: 
            viewModel.popHome
          
        ),
      ],
    );
  }

  @override
  AlerWidgetViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AlerWidgetViewModel();
}
