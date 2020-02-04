import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uvBoard: UIView!
    @IBOutlet weak var lbInfo: UILabel!
    var board:Board!
    var player:Player?
    
    func clearBoard(){
        let subviews = uvBoard.subviews
        var buttons:[UIButton] =  [UIButton]()
        for subview in subviews{
            let temp = subview.subviews.filter{$0 is UIButton}
            temp.forEach{buttons.append(($0 as! UIButton))}
        }
        for button in buttons{
            button.setTitle("", for: .normal)
        }
    }
    
    func handleLabelInfo(){
        lbInfo.text = "\(board.currentPlayer.description) to play"
    }
    
    func resetBoard(){
        board.restart()
        clearBoard()
        handleLabelInfo()
    }
    
    func clearButton(move:Move){
        let tag = "\(move.row + 1)\(move.column + 1)"
        guard let tagValue = Int(tag) else {return}
        let button = uvBoard.viewWithTag(tagValue) as! UIButton
        button.setTitle("", for: .normal)
    }
    
    func fillButton(move:Move){
        let tag = "\(move.row + 1)\(move.column + 1)"
        guard let tagValue = Int(tag) else {return}
        let button = uvBoard.viewWithTag(tagValue) as! UIButton
        button.setTitle(move.player.description, for: .normal)
    }
    
    func handleLabelEachMove(move:Move){
        if move.state == State.HasResult{
            lbInfo.text = "\(move.player.description) wins!!!"
        }
        if move.state == State.Draw{
            lbInfo.text = "Draws!!!"
        }
        handleLabelInfo()
    }
    
    func moveToCurrentMove(currentMove:Int){
        for i in 0..<currentMove{
            let move = board.game.moves[i]
            fillButton(move: move)
            board.fillOneCell(player: move.player, row: move.row, column: move.column)
            board.flipSide()
            board.setState(state: move.state)
            handleLabelEachMove(move: move)
        }
        board.setCurrentMove(currentMove: currentMove)
    }
    
    func loadGame(){
        board.load()
        moveToCurrentMove(currentMove: board.game.currentMove)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board.restart()
        clearBoard()
        handleLabelInfo()
        loadGame()
    }
    
    func makeGameMove(button:UIButton){
        guard let player = player else {return}
        button.setTitle("\(player.description)", for: .normal)
        if let winner = board.winner{
            lbInfo.text = "\(winner.description) wins!!!"
        }
        if board.state == State.Draw{
            lbInfo.text = "Draws!!!"
        }
    }
    
    func onButtonPressed(button:UIButton){
        if board.state == State.InProgress{
            let tag:String = String(button.tag)
            guard let row = Int(String((Array(tag)[0]))),
                let column = Int(String((Array(tag)[1]))) else {return}
            player = board.makeOneMove(row: row - 1, column: column - 1)
            handleLabelInfo()
            makeGameMove(button: button)
        }
    }
    
    @IBAction func onButtonsPressed(_ sender: UIButton) {
        onButtonPressed(button: sender)
    }
    

    @IBAction func onButtonNewGamePressed(_ sender: UIBarButtonItem) {
        resetBoard()
    }
    
    
    func handleFirstButton(){
        let currentMove = board.game.currentMove
        if currentMove > 0 {
            clearBoard()
            board.setCurrentMove(currentMove: 0)
            board.setCurrentPlayer(currentPlayer: board.game.moves[0].player)
            handleLabelInfo()
        }
    }
    
    @IBAction func onButtonFirstPressed(_ sender: UIButton) {
        handleFirstButton()
    }
    
    func handleButtonBack(){
        guard let currentMove = board.currentMove else {return}
        if currentMove > 0{
            let move = board.game.moves[currentMove - 1]
            clearButton(move: move)
            board.clearOneCell(row: move.row, column: move.column)
            board.setCurrentMove(currentMove: currentMove - 1)
            board.setState(state: move.state)
            board.flipSide()
            handleLabelInfo()
        }
    }
    
    @IBAction func onButtonBackPressed(_ sender: UIButton) {
        handleButtonBack()
    }
    
    func handleNextButton(){
        guard let currentMove = board.currentMove else {return}
        if currentMove < board.game.moves.count{
            let move = board.game.moves[currentMove]
            fillButton(move: move)
            board.fillOneCell(player: move.player, row: move.row, column: move.column)
            board.setCurrentMove(currentMove: currentMove + 1)
            board.setState(state: move.state)
            board.flipSide()
            handleLabelEachMove(move: move)
        }
    }
    
    @IBAction func onButtonNextPressed(_ sender: UIButton) {
        handleNextButton()
    }
    
    func handleButtonLast(){
        guard let currentMove = board.currentMove else {return}
        let numOfMoves = board.game.moves.count
        if currentMove < numOfMoves{
            for i in currentMove..<numOfMoves{
                let move = board.game.moves[i]
                fillButton(move: move)
                board.fillOneCell(player: move.player, row: move.row, column: move.column)
                board.flipSide()
                board.setState(state: move.state)
                handleLabelEachMove(move: move)
            }
            board.setCurrentMove(currentMove: numOfMoves)
        }
    }
    
    @IBAction func onButtonLastPressed(_ sender: UIButton) {
        handleButtonLast()
    }
    
}














