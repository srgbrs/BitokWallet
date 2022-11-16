
import UIKit

class PopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(backToIncomeVC), name: Notification.Name("backToIncomeVC"), object: nil)
        
    }
    
    @IBAction func backToIncomeVC(_ sender: Any) {
    
        print("TO POP UP VC")
        self.remove()
    
       }
    
    override func loadView() {
      self.view = PopUpView(viewModel: IncomeViewModel())
    }

}

