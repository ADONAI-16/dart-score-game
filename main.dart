import 'dart:io';

void main() {
  String playerName = "Player One";
  int score = 0;
  int level = 1;
  bool isRunning = true;

  print("🎮 Welcome to the Dart Score Game!");
  print("--------------------------------");

  while (isRunning) {
    print("\nMain Menu");
    print("1. Play Game");
    print("2. View Status");
    print("3. Reset Score");
    print("4. Exit");

    stdout.write("Choose an option (1-4): ");
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        playGameRounds(refScore: () => score, updateScore: (value) {
          score = value;
        });
        break;

      case '2':
        String rank = getPlayerRank(score);
        print("\n📊 Player Status");
        print("Name : $playerName");
        print("Score: $score");
        print("Rank : $rank");
        break;

      case '3':
        score = 0;
        print("\n🔄 Score has been reset.");
        break;

      case '4':
        print("\n Thanks for playing!");
        isRunning = false;
        break;

      default:
        print("\n❌ Invalid choice. Try again.");
    }
  }
}

void playGameRounds({
  required int Function() refScore,
  required void Function(int) updateScore,
}) {
  print("\n Starting game rounds...");

  for (int round = 1; round <= 5; round++) {
    print("\nRound $round");

    stdout.write("Enter points earned (0–20): ");
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print("⚠️ No input. Skipping round.");
      continue;
    }

    int points = int.tryParse(input) ?? -1;

    if (points < 0 || points > 20) {
      print("❌ Invalid points. Round skipped.");
      continue;
    }

    int newScore = refScore() + points;

    assert(newScore >= 0, "Score can never be negative");

    updateScore(newScore);
    print("✅ Points added! Total score: ${refScore()}");

    if (refScore() >= 50) {
      print("🏆 You reached the maximum score!");
      break;
    }
  }
}

String getPlayerRank(int score) {
  if (score < 20) {
    return "Beginner";
  } else if (score < 40) {
    return "Intermediate";
  } else {
    return "Expert";
  }
}
