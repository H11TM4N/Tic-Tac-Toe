class GameState {
  String player1;
  List<String> displayTiles;
  List<int> winTiles;
  final int boardSize;
  final int align;
  bool xTurn;
  int oWins;
  int xWins;
  int ties;
  int filledTiles = 0;

  GameState({
    required this.player1,
    required this.displayTiles,
    required this.winTiles,
    this.boardSize = 3,
    this.align = 3,
    this.xTurn = true,
    this.oWins = 0,
    this.xWins = 0,
    this.ties = 0,
    this.filledTiles = 0,
  });

  GameState.empty()
      : player1 = 'x',
        displayTiles = List<String>.filled(9, ''),
        winTiles = [],
        boardSize = 3,
        align = 3,
        xTurn = true,
        oWins = 0,
        xWins = 0,
        ties = 0,
        filledTiles = 0;

  GameState copyWith({
    String? player1,
    List<String>? displayTiles,
    List<int>? winTiles,
    int? boardSize,
    int? align,
    bool? xTurn,
    int? oWins,
    int? xWins,
    int? ties,
    int? filledTiles,
  }) {
    return GameState(
      player1: player1 ?? this.player1,
      displayTiles: displayTiles ?? this.displayTiles,
      winTiles: winTiles ?? this.winTiles,
      boardSize: boardSize ?? this.boardSize,
      align: align ?? this.align,
      xTurn: xTurn ?? this.xTurn,
      oWins: oWins ?? this.oWins,
      xWins: xWins ?? this.xWins,
      ties: ties ?? this.ties,
      filledTiles: filledTiles ?? this.filledTiles,
    );
  }

  @override
  String toString() {
    return 'GameState(player1: $player1, displayTiles: $displayTiles, winTiles: $winTiles, boardSize: $boardSize, align: $align, xTurn: $xTurn, oWins: $oWins, xWins: $xWins, ties: $ties, filledTiles: $filledTiles)';
  }
}
