

import UIKit

class SpendingsViewController: UIViewController {
    
    var viewModel = SpendingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector:#selector(toIncomeVC), name: Notification.Name("toIncomeVC"), object: nil)
        
    }
    
    override func loadView() {
      self.view = SpendingView(viewModel: SpendingsViewModel())
    }

    // segue
    @IBAction func toIncomeVC(_ sender: Any) {

        print("TO INCOME VC")
        let vc = IncomeViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: false, completion: nil)

    
       }

}
