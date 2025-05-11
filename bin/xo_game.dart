import 'dart:io';

/// This function prints the board shape as 3*3 and displays it on the screen.
void printBoard(List<String> board) {
  for (int i = 0; i < 9; i += 3) {
    print(' ${board[i]} | ${board[i + 1]} | ${board[i + 2]} ');
    if (i < 6) print('---+---+---');
  } //for()
} //printBoard()

/*
  This function checks the winning condition. 
  If all cells have the same symbol, if x or o, it will return true. If not, it will return flase.
*/
bool checkWin(List<String> board, String marker) {
  // This list represents the winning patterns in rows, columns, and diagonals.
  const List<List<int>> winPatterns = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // These represent rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // These represent columns
    [0, 4, 8], [2, 4, 6], // These represent diagonals
  ];
  for (var pattern in winPatterns) {
    if (pattern.every((idx) => board[idx] == marker)) {
      return true;
    } //if()
  } //for()

  return false;
} //checkWin()

/*
 This function checks for a tie if there is no empty cell and no loss or win occurs. 
 In this case, the tie will be true and return false otherwise.
*/
bool isDraw(List<String> board) => !board.contains(' ');

/*
  This function verifies that the user enters correct field numbers within the required range, 
  which is from 1 to 9 and empty.
*/
int getValidMove(List<String> board) {
  while (true) {
    stdout.write('Enter your move (1-9): ');
    String? input = stdin.readLineSync();
    int? pos = int.tryParse(input ?? '');
    if (pos == null || pos < 1 || pos > 9) {
      print('Invalid input. Please enter a number between 1 and 9.');
      continue;
    } //if()
    if (board[pos - 1] != ' ') {
      print('Cell already taken. Choose an empty cell.');
      continue;
    } //if()
    return pos - 1;
  } //while()
} //getValidMove()

void main() {
  print('Tic-Tac-Toe');

  while (true) {
    // Initialize board
    List<String> board = List.filled(9, ' ');

    // Here the player selects which symbol he will choose to play.
    stdout.write('Player 1, choose your marker (X/O): ');
    String? choice = stdin.readLineSync()?.toUpperCase();
    if (choice!.isNotEmpty) {
      if (choice == "X" || choice == "O") {
        String player1 = (choice == 'O') ? 'O' : 'X';
        String player2 = (player1 == 'X') ? 'O' : 'X';

        print('Player 1: $player1 vs Player 2: $player2');

        String currentMarker = player1;

        // Here the game will start looping until a win or draw occurs.
        while (true) {
          print('\nBoard:');
          // Here the shape of the board will be printed.
          printBoard(board);

          // Here the user will be asked for the cell number on which the code is to be placed.
          int move = getValidMove(board);
          board[move] = currentMarker;

          // Here it will be checked whether there is a win or a draw.
          if (checkWin(board, currentMarker)) {
            printBoard(board);
            print('Player with marker $currentMarker wins!');
            break;
          } else if (isDraw(board)) {
            printBoard(board);
            print('Game ended in a draw.');
            break;
          } //else if()

          // Switch player
          currentMarker = (currentMarker == player1) ? player2 : player1;
        } //while()

        // Restart option
      } else {
        print('Please select only X or O!');
      }
    } else {
      print('Please enter a value!');
    }

    stdout.write('\nPlay again? (y/n): ');
    String? again = stdin.readLineSync()?.toLowerCase();
    if (again != 'y') {
      print('Thank you for playing!');
      break;
    } //if()
  } //while()
} //main()
