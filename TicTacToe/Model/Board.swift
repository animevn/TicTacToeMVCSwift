import Foundation

class Board{
    
    var cells:Cells<Cell>
    var winner:Player?
    var currentPlayer:Player!
    var state:State!
    var game:Game!
    var currentMove:Int!
    
    init() {
        cells = Cells(rows: 3, columns: 3)
        winner = nil
        currentPlayer = Player.X
        state = State.InProgress
        game = Game()
        currentMove = 0
    }
    
    func clearCells(){
        cells = Cells(rows: 3, columns: 3)
    }
    
    func restart(){
        clearCells()
        winner = nil
        currentPlayer = Player.X
        state = State.InProgress
        game = Game()
        currentMove = 0
    }
    
    func isWinningMove(player:Player, row:Int, column:Int)->Bool{
            cells[0, column]?.player == player
            && cells[1, column]?.player == player
            && cells[2, column]?.player == player
        ||  cells[row, 0]?.player == player
            && cells[row, 1]?.player == player
            && cells[row, 2]?.player == player
        ||  cells[0, 0]?.player == player
            && cells[1, 1]?.player == player
            && cells[2, 2]?.player == player
        ||  cells[0, 2]?.player == player
            && cells[1, 1]?.player == player
            && cells[2, 0]?.player == player
    }
    
    func isCoordValid(coord:Int)->Bool{
        coord >= 0 && coord <= 2
    }
    
    func isCellEmpty(row:Int, column:Int)->Bool{
        cells[row, column] == nil
    }
    
    func isCellValidForPlayed(row:Int, column:Int)->Bool{
        state == State.InProgress
            && isCoordValid(coord: row)
            && isCoordValid(coord: column)
            && isCellEmpty(row: row, column: column)
    }
    
    func isBoardFull()->Bool{
        for i in 0..<3{
            for j in 0..<3{
                if cells[i, j] == nil{
                    return false
                }
            }
        }
        return true
    }
    
    func flipSide(){
        currentPlayer = (currentPlayer == Player.X) ? Player.O : Player.X
    }
    
    //when users move back and forth with buttons, if they choose a new move
    //then the game will continue from that move, and all moves that come following
    //that move will be deleted.
    func deleteMoveAfterCurrentMove(){
        if currentMove < game.moves.count{
            game.setMoves(moves: Array(game.moves[0..<currentMove]))
        }
    }
    
    func addMoveToCurrentGame(player:Player, row:Int, column:Int){
        game.addMove(move: Move(player: player, state: state, row: row, column: column))
        currentMove += 1
        game.setCurrentMove(currentMove: currentMove)
        
    }
    
    func makeOneMove(row:Int, column:Int)->Player?{
        var player:Player? = nil
        if isCellValidForPlayed(row: row, column: column){
            deleteMoveAfterCurrentMove()
            cells[row, column] = Cell(player: currentPlayer)
            player = currentPlayer
            if isWinningMove(player: currentPlayer, row: row, column: column){
                state = State.HasResult
                winner = player
            }else if state == State.InProgress && isBoardFull() {
                state = State.Draw
            }
            addMoveToCurrentGame(player: currentPlayer, row: row, column: column)
            flipSide()
        }
        return player
    }
    
    func clearOneCell(row:Int, column:Int){
        cells[row, column] = nil
    }
    
    func fillOneCell(player:Player, row:Int, column:Int){
        if isCellEmpty(row: row, column: column){
            cells[row, column] = Cell(player: player)
        }
    }
    
    func setCurrentMove(currentMove:Int){
        self.currentMove = currentMove
        game.setCurrentMove(currentMove: currentMove)
    }
    
    func save(){
        guard let data = try? JSONEncoder().encode(game) else {
            print("error")
            return
            
        }
        UserDefaults.standard.set(data, forKey: "save")
    }
    
    func load(){
        guard let data = UserDefaults.standard.data(forKey: "save") else {
            print("load error")
            return
        }
        game = try? JSONDecoder().decode(Game.self, from: data)
    }
    
    func setState(state:State){
        self.state = state
    }
    
    func setCurrentPlayer(currentPlayer:Player){
        self.currentPlayer = currentPlayer
    }
    
}














