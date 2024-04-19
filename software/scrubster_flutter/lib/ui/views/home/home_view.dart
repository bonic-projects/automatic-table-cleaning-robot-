import 'package:flutter/material.dart';
import 'package:scrubster/ui/common/ui_helpers.dart';
import 'package:scrubster/ui/smart_widgets/online_status.dart';
import 'package:scrubster/ui/views/home/widgets/mainButtons/rotateButton/left_rotate_button.dart';
import 'package:scrubster/ui/views/home/widgets/mainButtons/rotateButton/right_rotate_button.dart';
import 'package:scrubster/ui/views/home/widgets/mainButtons/stop_button.dart';
import 'package:scrubster/ui/views/home/widgets/mainButtons/triangleWidget/dwnwd_triangle.dart';
import 'package:scrubster/ui/views/home/widgets/mainButtons/triangleWidget/frwrd_triangle.dart';
import 'package:scrubster/ui/views/home/widgets/mainButtons/triangleWidget/lftwrd_triangle.dart';
import 'package:scrubster/ui/views/home/widgets/mainButtons/triangleWidget/rgtward_triangle.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Scrubster",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IsOnlineWidget(),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey[600],
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ForwardTriangle(
                  onTap: () => viewModel.isForward('f'),
                  icon: const Icon(
                    Icons.keyboard_double_arrow_up_outlined,
                    size: 60,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LeftwardTriangle(
                      onTap: () => viewModel.isLeft('l'),
                    ),
                    StopButton(
                      onTap: () => viewModel.isStop('s'),
                    ),
                    RightwardTriangle(
                      onTap: () => viewModel.isRight('r'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        LeftRotateButton(
                          onTap: () => viewModel.isLeftR('lr'),
                        ),
                        const Text("Left")
                      ],
                    ),
                    DownwardTriangle(
                      onTap: () => viewModel.isBackward('b'),
                      icon: const Icon(
                        Icons.keyboard_double_arrow_down_outlined,
                        size: 60,
                      ),
                    ),
                    Column(
                      children: [
                        RightRotateButton(
                          onTap: () => viewModel.isRightR('rr'),
                        ),
                        const Text("Right")
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                verticalSpaceSmall,
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        horizontalSpaceTiny,
                        const Text(
                          "Stepper1",
                          style: TextStyle(fontSize: 20),
                        ),
                        horizontalSpaceSmall,
                        ElevatedButton(
                          onPressed: viewModel.isAutoButton,
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey)),
                          child: const Text(
                            'Automatic',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        horizontalSpaceSmall,
                        const Text(
                          'Stepper2',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.isRight('w');
                      },
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey)),
                      child: const Text(
                        'Pump',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ForwardTriangle(
                          onTap: () => viewModel.isStepper1up('s1u'),
                          icon: const Icon(
                            Icons.arrow_upward,
                            size: 50,
                          ),
                        ),
                        verticalSpaceSmall,
                        StopButton(
                          onTap: () => viewModel.isStepper1stop('s1s'),
                        ),
                        verticalSpaceSmall,
                        DownwardTriangle(
                          onTap: () => viewModel.isStepper1down('s1d'),
                          icon: const Icon(
                            Icons.arrow_downward,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ForwardTriangle(
                          onTap: () => viewModel.isStepper2up('s2u'),
                          icon: const Icon(
                            Icons.arrow_upward,
                            size: 50,
                          ),
                        ),
                        verticalSpaceSmall,
                        StopButton(
                          onTap: () => viewModel.isStepper2stop('s2s'),
                        ),
                        verticalSpaceSmall,
                        DownwardTriangle(
                          onTap: () => viewModel.isStepper2down('s2d'),
                          icon: const Icon(
                            Icons.arrow_downward,
                            size: 50,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.onModelReady();
    super.onViewModelReady(viewModel);
  }
}
