import Foundation

class Cells<T>{
    let rows:Int
    let columns:Int
    var cells:[T?]
    
    init(rows:Int, columns:Int) {
        self.rows = rows
        self.columns = columns
        cells = Array<T?>(repeating: nil, count: rows * columns)
    }
    
    subscript(row:Int, column:Int)->T?{
        get{
            return cells[(row * columns) + column]
        }
        
        set{
            cells[(row * columns) + column] = newValue
        }
    }
    
}
