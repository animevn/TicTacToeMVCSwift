import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = view.viewWithTag(11) as! UIButton
        button.setTitle("test", for: .normal)
    }

    @IBAction func onButtonNewGamePressed(_ sender: UIBarButtonItem) {
    }
    
}

