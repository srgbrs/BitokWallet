import UIKit

class IncomeViewController: UIViewController {
    
    var viewModel = IncomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(toSpendingVC), name: Notification.Name("toSpendingVC"), object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(toPopUpVC), name: Notification.Name("toPopUpVC"), object: nil)

    }
    
    override func loadView() {
      self.view = IncomeView(viewModel: IncomeViewModel())
    }
    
    
    // segue
    @objc func toSpendingVC(_ sender: Any) {
        let vc = SpendingsViewController()
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.modalTransitionStyle = .crossDissolve
        
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.present(vc, animated: false, completion: nil)
        }
    
       }
    
    // segue
    @objc func toPopUpVC(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            self.add(PopUpViewController(), frame: self.view.frame)
        }
       }
}


