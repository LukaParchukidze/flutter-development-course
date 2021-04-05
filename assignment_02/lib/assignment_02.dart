import 'dart:io';
import 'dart:math';

void diceRoller() {
  print(
      "Welcome to Dice Roller. Wish You a Great Success ! \nType 'exit' to stop the game");

  int userScore = 0;
  int computerScore = 0;

  while (true) {
    stdout.write(
        "\nPlease Enter or Type Something (\"exit\" to stop the game): ");

    String userResponse = stdin.readLineSync().toLowerCase();

    if (userResponse == "exit") {
      if (userScore > computerScore) {
        stdout.write("You win, $userScore:$computerScore \n");
      } else if (userScore < computerScore) {
        stdout.write("Computer wins, $computerScore:$userScore \n");
      } else {
        stdout.write("It's a tie ! $userScore:$userScore \n");
      }

      print("Good Game, Bye!");
      break;
    }

    int userDicesSum = generateRandom(6) + generateRandom(6);
    int computerDicesSum = generateRandom(6) + generateRandom(6);

    stdout.write(
        "Your Score: $userDicesSum, Computer Score: $computerDicesSum \n");

    if (userDicesSum > computerDicesSum) {
      userScore++;
      stdout.write(
          "You win this round by ${userDicesSum - computerDicesSum} points");
    } else if (userDicesSum < computerDicesSum) {
      computerScore++;
      stdout.write(
          "Computer win this round by ${computerDicesSum - userDicesSum} points");
    } else {
      stdout.write("It's a Tie");
    }
  }
}

int generateRandom(int maxValue) {
  return Random().nextInt(maxValue) + 1;
}
