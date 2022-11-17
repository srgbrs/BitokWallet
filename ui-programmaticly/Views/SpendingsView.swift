import UIKit
import CoreData

class SpendingView: UIView {
    
    private var viewModel: SpendingsViewModel

    private let amountContainerView = UIView()
    private let categoriesContainerView = UIView()
    
    private let btcRateLabel = UILabel()
    private let amountHeaderLabel = UILabel()
    private let categoryHeaderLabel = UILabel()
    
    private var amountTextField = UITextField()
    private let amountLabel = UILabel()
    
    private let categoryPicker = UIPickerView()
    private let addTransactionButton = UIButton()
    
    private let arrowBackButton = UIButton()
    
    init(viewModel: SpendingsViewModel) {
       self.viewModel = viewModel
       
       super.init(frame: .zero)

       self.setup()
       self.style()
       self.setupBindings()
       self.setupConstraints()
        
        self.viewModel.updateBtcRate()
     }
     
     required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
    
    func setup() {
        self.addSubview(self.amountContainerView)
        self.addSubview(self.categoriesContainerView)
        self.addSubview(self.btcRateLabel)
        self.addSubview(self.amountHeaderLabel)
        self.addSubview(self.categoryHeaderLabel)
        self.addSubview(self.amountTextField)
        self.addSubview(self.amountLabel)
        self.addSubview(self.categoryPicker)
        self.addSubview(self.addTransactionButton)
        self.addSubview(self.arrowBackButton)

        self.arrowBackButton.addTarget(self, action: #selector(didTapArrow(_:)), for: .touchUpInside)
        self.addTransactionButton.addTarget(self, action: #selector(didTapAddTransaction(_:)), for: .touchUpInside)
        
        self.arrowBackButton.addTarget(self, action: #selector(arrowBackButtonAnimator(_:)), for: .touchUpInside)
        self.addTransactionButton.addTarget(self, action: #selector(transactionButtonAnimator(_:)), for: .touchUpInside)

        
      }
    // MARK: - Animation:
    @objc fileprivate func arrowBackButtonAnimator(_ sender: UIButton){
         self.animateView(sender)
        
    }
    
    @objc fileprivate func transactionButtonAnimator(_ sender: UIButton) {
         self.animateView(sender)
    }
    
    fileprivate func animateView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn ,animations: {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        }, completion: { (_) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2,options: .curveEaseIn ,animations: {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            
        })
    }
    
    func setupBindings()
    {
        viewModel.btcRate.bind({ (btcRate) in
            DispatchQueue.main.async {
                self.btcRateLabel.text = btcRate
                self.updateConstraints()
                self.layoutSubviews()
            }
            
        })
        
    }
    
    @objc func didTapArrow(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("toIncomeVC"), object: nil)
    
     }
    
    
    // TODO: move validation to ViewModel
    @objc func didTapAddTransaction(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("transactionVerification"), object: nil)
        
        if (amountTextField.hasText) {
            if (amountTextField.text!.isNumber) {
                
                let category = TransactionCategory.allCases[viewModel.selectedCategory.value].toString()
                let date = Date.init()
                
                UserDefaultsManager.updateWallet(amount: -1 * Int( amountTextField.text!)!)
 
                let coreDataHandler = CoreDataHandler()
                coreDataHandler.createTransaction(amount: (-1) * Int( amountTextField.text!)!, date: "", dateString: date.toString(), type: TransactionType.expense.toString(), category: category)
 

                NotificationCenter.default.post(name: Notification.Name("toIncomeVC"), object: nil)
                
            } else { // IF NOT NUMBER
                addTransactionButton.shake()
                amountTextField.text = ""
            }
        } else { // IF HAS NO TEXT
            addTransactionButton.shake()
            amountTextField.shake()
        }
                
     }
    
    // MARK: - Style:
    func style(){
        self.backgroundColor = UIColor(named: "LightBlue")
        self.amountContainerView.backgroundColor = UIColor(named: "LightPastel")
        self.categoriesContainerView.backgroundColor = UIColor(named: "LightPastel")
        
        self.addTransactionButton.backgroundColor = UIColor(named: "LightGrey")
        
        self.amountContainerView.layer.cornerRadius = 20.0
        self.categoriesContainerView.layer.cornerRadius = 20.0
        
        self.amountContainerView.clipsToBounds = true
        self.categoriesContainerView.clipsToBounds = true
        
        self.addTransactionButton.setTitle("+ Add Transaction", for: .normal)
        self.addTransactionButton.titleLabel?.font = UIFont(name: "OutlastSlab", size: 24.0)
        
        self.addTransactionButton.setTitleColor(.black, for: .normal)
        
        self.addTransactionButton.layer.cornerRadius = 10
        self.addTransactionButton.clipsToBounds = true
        
        self.addTransactionButton.configuration = .none
        
        self.btcRateLabel.text = "1$ = 4154 BTC"
        self.btcRateLabel.textColor = .white
        self.btcRateLabel.font = UIFont(name: "OutlastSlab", size: 20.0)
        self.btcRateLabel.textAlignment = .right
        self.btcRateLabel.adjustsFontSizeToFitWidth = true
        
        self.amountLabel.text = "bitcoins"
        self.amountLabel.textColor = UIColor(named: "DarkBlue")
        self.amountLabel.font = UIFont(name: "OutlastSlab", size: 24.0)
        self.amountLabel.textAlignment = .left
        self.amountLabel.adjustsFontSizeToFitWidth = true
        
        self.amountHeaderLabel.text = "Amount"
        self.amountHeaderLabel.textColor = UIColor(named: "LightBlue")
        self.amountHeaderLabel.font = UIFont(name: "BRCobane-Medium", size: 20.0)
        self.amountHeaderLabel.textAlignment = .left
        self.amountHeaderLabel.adjustsFontSizeToFitWidth = true
        
        self.categoryHeaderLabel.text = "Category"
        self.categoryHeaderLabel.textColor = UIColor(named: "LightBlue")
        self.categoryHeaderLabel.font = UIFont(name: "BRCobane-Medium", size: 20.0)
        self.categoryHeaderLabel.textAlignment = .left
        self.categoryHeaderLabel.adjustsFontSizeToFitWidth = true
        
        self.btcRateLabel.text = "1$ = 4154 BTC"
        self.btcRateLabel.textColor = .white
        self.btcRateLabel.font = UIFont(name: "OutlastSlab", size: 20.0)
        self.btcRateLabel.textAlignment = .right
        self.btcRateLabel.adjustsFontSizeToFitWidth = true
        
        self.amountTextField.backgroundColor = .white
        self.amountTextField.borderStyle = .roundedRect
        self.amountTextField.font = UIFont(name: "BRCobane-Medium", size: 20.0)
        self.amountTextField.textColor = UIColor.black
        self.amountTextField.textAlignment = .center
        self.amountTextField.adjustsFontForContentSizeCategory = true
        self.amountTextField.keyboardType = .decimalPad
        self.amountTextField.returnKeyType = .done
        self.amountTextField.enablesReturnKeyAutomatically = false
        
        self.arrowBackButton.setImage(UIImage(named: "back_arrow"), for: .normal)
        self.arrowBackButton.tintColor = .clear
        self.arrowBackButton.backgroundColor = .clear
        
        self.categoryPicker.dataSource = viewModel
        self.categoryPicker.delegate = viewModel
    }
    
    // MARK: - Constraints:
    func setupConstraints() {
        [
            amountContainerView,
            categoriesContainerView,
            btcRateLabel,
            amountHeaderLabel,
            categoryHeaderLabel,
            amountTextField,
            amountLabel,
            categoryPicker,
            addTransactionButton,
            arrowBackButton
            ].forEach {
              $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            self.categoriesContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor , constant: -10),
            self.categoriesContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.categoriesContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.categoriesContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.56)

          ])
        
        NSLayoutConstraint.activate([
            self.amountContainerView.bottomAnchor.constraint(equalTo: self.categoriesContainerView.topAnchor , constant: -10),
            self.amountContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.amountContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.amountContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.28)
            
          ])
        
        NSLayoutConstraint.activate([
            self.addTransactionButton.bottomAnchor.constraint(equalTo: self.categoriesContainerView.bottomAnchor , constant: -10),
            self.addTransactionButton.leadingAnchor.constraint(equalTo: categoriesContainerView.leadingAnchor, constant: 10),
            self.addTransactionButton.trailingAnchor.constraint(equalTo: categoriesContainerView.trailingAnchor, constant: -10),
            self.addTransactionButton.heightAnchor.constraint(equalTo: categoriesContainerView.heightAnchor, multiplier: 0.08)
            
          ])
        
        NSLayoutConstraint.activate([
            self.amountHeaderLabel.topAnchor.constraint(equalTo: self.amountContainerView.topAnchor , constant:0),
            self.amountHeaderLabel.leadingAnchor.constraint(equalTo: amountContainerView.leadingAnchor, constant: 10),
            self.amountHeaderLabel.trailingAnchor.constraint(equalTo: amountContainerView.trailingAnchor, constant: -10),
            self.amountHeaderLabel.heightAnchor.constraint(equalTo: self.amountContainerView.heightAnchor, multiplier: 0.11)

          ])
        
        NSLayoutConstraint.activate([
            self.categoryHeaderLabel.topAnchor.constraint(equalTo: self.categoriesContainerView.topAnchor , constant:0),
            self.categoryHeaderLabel.leadingAnchor.constraint(equalTo: categoriesContainerView.leadingAnchor, constant: 10),
            self.categoryHeaderLabel.trailingAnchor.constraint(equalTo: categoriesContainerView.trailingAnchor, constant: -10),
            self.categoryHeaderLabel.heightAnchor.constraint(equalTo: self.categoriesContainerView.heightAnchor, multiplier: 0.08)

          ])
        
        NSLayoutConstraint.activate([
            self.categoryPicker.topAnchor.constraint(equalTo: self.categoryHeaderLabel.bottomAnchor , constant:10),
            self.categoryPicker.leadingAnchor.constraint(equalTo: categoriesContainerView.leadingAnchor, constant: 10),
            self.categoryPicker.trailingAnchor.constraint(equalTo: categoriesContainerView.trailingAnchor, constant: -10),
            self.categoryPicker.bottomAnchor.constraint(equalTo: self.addTransactionButton.topAnchor , constant: -20)

          ])
        
        NSLayoutConstraint.activate([
            self.btcRateLabel.bottomAnchor.constraint(equalTo: self.amountContainerView.topAnchor , constant: -5),
            self.btcRateLabel.widthAnchor.constraint(equalTo: amountContainerView.widthAnchor, multiplier: 0.5),
            self.btcRateLabel.trailingAnchor.constraint(equalTo: amountContainerView.trailingAnchor, constant: 0),
            self.btcRateLabel.heightAnchor.constraint(equalTo: amountContainerView.heightAnchor, multiplier: 0.16)
            
          ])
        
        NSLayoutConstraint.activate([
            self.amountTextField.heightAnchor.constraint(equalTo: self.amountContainerView.heightAnchor, multiplier: 0.16),
            self.amountTextField.widthAnchor.constraint(equalTo: self.amountContainerView.widthAnchor, multiplier: 0.19),
            self.amountTextField.centerYAnchor.constraint(equalTo: self.amountContainerView.centerYAnchor),
            self.amountTextField.centerXAnchor.constraint(equalToSystemSpacingAfter: self.amountContainerView.centerXAnchor, multiplier: 1.2)

          ])
        
        NSLayoutConstraint.activate([
            self.amountLabel.leadingAnchor.constraint(equalTo: self.amountTextField.trailingAnchor, constant: 5),
            self.amountLabel.widthAnchor.constraint(equalTo: self.amountContainerView.widthAnchor, multiplier: 0.35),
            self.amountLabel.heightAnchor.constraint(equalTo: self.amountTextField.heightAnchor),
            self.amountLabel.centerYAnchor.constraint(equalTo: amountTextField.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            self.arrowBackButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.arrowBackButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.arrowBackButton.heightAnchor.constraint(equalToConstant: 50),
            self.arrowBackButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
