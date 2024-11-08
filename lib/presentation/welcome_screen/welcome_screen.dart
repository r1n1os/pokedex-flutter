import 'package:flutter/material.dart';
import 'package:pokedex/presentation/pokemon_list_screen/pokemon_list_screen.dart';
import 'package:pokedex/utils/extentions.dart';
import 'package:sliding_action_button/sliding_action_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height / 2,
                color: Colors.red,
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.46, left: MediaQuery.sizeOf(context).width  * 0.42),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Container(
                    height: 20,
                    width: 20,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircleSlideToActionButton(
                width: 300,
                parentBoxRadiusValue: 27,
                circleSlidingButtonSize: 47,
                leftEdgeSpacing: 3,
                rightEdgeSpacing: 3,
                initialSlidingActionLabel: 'Enter the world of Pokemon',
                finalSlidingActionLabel: 'Enter the world of Pokemon',
                circleSlidingButtonIcon: const Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                ),
                parentBoxBackgroundColor: Colors.red,
                parentBoxDisableBackgroundColor: Colors.grey,
                circleSlidingButtonBackgroundColor: Colors.black,
                isEnable: true,
                onSlideActionCompleted: () {
                  context.pushAndRemoveUntilNavigation(
                    screenToNavigate: PokemonListScreen(),
                  );
                },
                onSlideActionCanceled: () {},
              ),
            ),
          ),
          SizedBox(height: 100,),
        ],
      ),
    );
  }
}
