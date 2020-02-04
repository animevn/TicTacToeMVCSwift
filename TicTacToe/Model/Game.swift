import Foundation

enum Player:Int, CustomStringConvertible, Codable{
    case X = 0, O
    var description: String{
        switch self{
        case .X: return "X"
        case .O: return "O"
        }
    }
}

enum State:Int, Codable{
    case InProgress = 0, HasResult, Draw
}

struct Cell:Codable{
    let player:Player
}

struct Move:Codable{
    let player:Player
    let state:State
    let row:Int
    let column:Int
}

struct Game:Codable{
    var moves = [Move]()
    var currentMove:Int = 0
    
    mutating func setCurrentMove(currentMove:Int){
        self.currentMove = currentMove
    }
    
    mutating func addMove(move:Move){
        moves.append(move)
    }
    
    mutating func setMoves(moves:[Move]){
        self.moves = moves
    }
    
}
