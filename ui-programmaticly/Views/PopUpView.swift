import UIKit

class PopUpView: UIView {
    
    private let backgroundView = UIView()
    private let outerViewContainer = UIView()
    private let innerViewContainer = UIView()
    
    private let addAmountLabel = UILabel()
    private let addAmountButton = UIButton()
    
    private let textField = UITextField()
    
    init(viewModel: IncomeViewModel) {
        
        super.init(frame: .zero)
        
        self.setup()
        self.style()
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.addSubview(self.backgroundView)
        self.addSubview(self.outerViewContainer)
        self.addSubview(self.innerViewContainer)
        self.addSubview(self.addAmountLabel)
        self.addSubview(self.addAmountButton)
        self.addSubview(self.textField)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.onBackgroundTapped (_:)))
        self.backgroundView.addGestureRecognizer(gesture)
        
        self.addAmountButton.addTarget(self, action: #selector(didTapAddAmountButton(_:)), for: .touchUpInside)
        
        self.addAmountButton.addTarget(self, action: #selector(addButtonAnimator(_:)), for: .touchUpInside)
        
        
    }
    
    func verificateAmount() {
        // verification
        
        if (textField.hasText) {
            if (textField.text!.isNumber) {

                let date = Date.init()
                
                UserDefaultsManager.updateWallet(amount: Int(textField.text!)!)
                
                let coreDataHandler = CoreDataHandler()
                coreDataHandler.createTransaction(amount: Int( textField.text!)!, date: "", dateString: date.toString(), type: TransactionType.profit.toString(), category: TransactionCategory.uncategorized.toString())
                
                NotificationCenter.default.post(name: Notification.Name("backToIncomeVC"), object: nil)

            } else { // IF NOT NUMBER
                addAmountButton.shake()
                textField.text = ""
            }
        } else { // IF HAS NO TEXT
            addAmountButton.shake()
            textField.shake()
        }
}
    
    @objc func didTapAddAmountButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("didTapAddAmountButton"), object: nil)
    
        verificateAmount()
        NotificationCenter.default.post(name: Notification.Name("updateBtcAmount"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("updateTransactionsTable"), object: nil)
        
     }
    
    @objc func onBackgroundTapped(_ sender:UITapGestureRecognizer){
        print("onBackgroundTapped")
        NotificationCenter.default.post(name: Notification.Name("backToIncomeVC"), object: nil)
    }
    
    @objc fileprivate func addButtonAnimator(_ sender: UIButton) {
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
    
    
    // MARK: - Style:
    func style() {
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor(named: "LightGrey")
        self.backgroundView.layer.opacity = 0.6
        self.innerViewContainer.backgroundColor = UIColor(named: "LightPastel")
        self.outerViewContainer.backgroundColor = UIColor(named: "LightBlue")
        
        self.addAmountButton.backgroundColor = UIColor(named: "LightGrey")
        
        self.innerViewContainer.layer.cornerRadius = 20.0
        self.outerViewContainer.layer.cornerRadius = 20.0
        
        self.innerViewContainer.clipsToBounds = true
        self.outerViewContainer.clipsToBounds = true
        
        self.addAmountButton.setTitle("+ Add Amount", for: .normal)
         self.addAmountButton.titleLabel?.font = UIFont(name: "OutlastSlab", size: 24.0)
        
        self.addAmountButton.setTitleColor(.black, for: .normal)
        
        self.textField.backgroundColor = .white
        self.textField.borderStyle = .roundedRect
        
        self.addAmountLabel.text = "Add Amount"
        self.addAmountLabel.textColor = UIColor(named: "LightBlue")
        self.addAmountLabel.font = UIFont(name: "BRCobane-Medium", size: 20.0)
        self.addAmountLabel.textAlignment = .left
        self.addAmountLabel.adjustsFontSizeToFitWidth = true
        
        self.addAmountButton.setTitle("+ Add Amount", for: .normal)
        self.addAmountButton.titleLabel?.font = UIFont(name: "OutlastSlab", size: 24.0)
        self.addAmountButton.setTitleColor(.black, for: .normal)
        self.addAmountButton.layer.cornerRadius = 10
        self.addAmountButton.clipsToBounds = true
        self.addAmountButton.configuration = .none
        
        self.textField.backgroundColor = .white
        self.textField.borderStyle = .roundedRect
        self.textField.font = UIFont(name: "BRCobane-Medium", size: 20.0)
        self.textField.textColor = UIColor.black
        self.textField.textAlignment = .center
        self.textField.adjustsFontForContentSizeCategory = true
        self.textField.keyboardType = .decimalPad
        self.textField.returnKeyType = .done
        self.textField.enablesReturnKeyAutomatically = false
        
    }
    
    // MARK: - Constraints:
    func setupConstraints() {
        
        [
            outerViewContainer,
            innerViewContainer,
            addAmountLabel,
            addAmountButton,
            textField,
            backgroundView
            ].forEach {
              $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
          ])
        
        
        NSLayoutConstraint.activate([
            self.outerViewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.outerViewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.outerViewContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            self.outerViewContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
          ])
        
        NSLayoutConstraint.activate([
            self.innerViewContainer.leadingAnchor.constraint(equalTo: outerViewContainer.leadingAnchor, constant: 9),
            self.innerViewContainer.trailingAnchor.constraint(equalTo: outerViewContainer.trailingAnchor, constant: -9),
            self.innerViewContainer.topAnchor.constraint(equalTo: outerViewContainer.topAnchor, constant: 9),
            self.innerViewContainer.bottomAnchor.constraint(equalTo: outerViewContainer.bottomAnchor, constant: -9),
          ])
        
        NSLayoutConstraint.activate([
            self.addAmountLabel.topAnchor.constraint(equalTo: self.innerViewContainer.topAnchor , constant:0),
            self.addAmountLabel.leadingAnchor.constraint(equalTo: innerViewContainer.leadingAnchor, constant: 10),
            self.addAmountLabel.trailingAnchor.constraint(equalTo: innerViewContainer.trailingAnchor, constant: 10),
            self.addAmountLabel.heightAnchor.constraint(equalTo: self.innerViewContainer.heightAnchor, multiplier: 0.2)

          ])
        
        NSLayoutConstraint.activate([
            self.addAmountButton.bottomAnchor.constraint(equalTo: self.innerViewContainer.bottomAnchor , constant: -10),
            self.addAmountButton.leadingAnchor.constraint(equalTo: self.innerViewContainer.leadingAnchor, constant: 10),
            self.addAmountButton.trailingAnchor.constraint(equalTo: self.innerViewContainer.trailingAnchor, constant: -10),
            self.addAmountButton.heightAnchor.constraint(equalTo: self.innerViewContainer.heightAnchor, multiplier: 0.21)
            
          ])
        
        NSLayoutConstraint.activate([
            self.textField.centerYAnchor.constraint(equalTo: innerViewContainer.centerYAnchor),
            self.textField.centerXAnchor.constraint(equalTo: innerViewContainer.centerXAnchor),
            self.textField.heightAnchor.constraint(equalTo: self.innerViewContainer.heightAnchor, multiplier: 0.18),
            self.textField.widthAnchor.constraint(equalTo: self.innerViewContainer.widthAnchor, multiplier: 0.47)
        ])
    }
}
