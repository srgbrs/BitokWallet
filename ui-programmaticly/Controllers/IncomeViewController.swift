
import UIKit

class IncomeViewController: UIViewController {
    
    var viewModel = IncomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.networkServices.networkQuery.rate)

        NotificationCenter.default.addObserver(self, selector:#selector(toSpendingVC), name: Notification.Name("toSpendingVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(toPopUpVC), name: Notification.Name("toPopUpVC"), object: nil)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func loadView() {
      self.view = IncomeView(viewModel: IncomeViewModel())
    }
    
    
    // segue
    @IBAction func toSpendingVC(_ sender: Any) {
    
        print("TO SPENDING VC")
        let vc = SpendingsViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(vc, animated: false, completion: nil)

    
       }
    
    // segue
    @IBAction func toPopUpVC(_ sender: Any) {
    
        print("TO POP UP VC")

        self.add(PopUpViewController(), frame: self.view.frame)
    
       }
}


