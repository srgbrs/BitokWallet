
import UIKit

class LoadingViewController: UIViewController {
    
    var viewModel = LoadingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
      self.view = LoadingMainView(viewModel: LoadingViewModel())
    }


}

