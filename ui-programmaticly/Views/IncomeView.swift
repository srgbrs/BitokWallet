

import UIKit

class IncomeView: UIView {
    
    private var viewModel: IncomeViewModel


    private let amountContainerView = UIView()
    private let transactionsContainerView = UIView()
    
    private let btcRateLabel = UILabel()
    private let btcAmountLabel = UILabel()
    
    private let addIncomeButton = UIButton()
    private let addTransactionButton = UIButton()
    
    private let informationLabel = UILabel()
    private let headerLabel = UILabel()
    private let transactionsTableView = UITableView()
    
        
    init(viewModel: IncomeViewModel) {
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
    
    func setupBindings()
    {
        
        viewModel.btcRate.bind({ (btcRate) in
            DispatchQueue.main.async {
                self.btcRateLabel.text = btcRate
            }

        })
        
        viewModel.btcAmount.bind({ (btcAmount) in
            DispatchQueue.main.async {
                self.btcAmountLabel.text = btcAmount
            }
            //  self.btcAmountLabel.text = btcAmount

        })

    }
    
    func setup() {
        self.addSubview(self.amountContainerView)
        self.addSubview(self.transactionsContainerView)
        
        self.addSubview(self.btcRateLabel)
        self.addSubview(self.btcAmountLabel)
        
        self.addSubview(self.addIncomeButton)
        self.addSubview(self.addTransactionButton)
        
        self.addSubview(self.informationLabel)
        self.addSubview(self.transactionsTableView)
        self.addSubview(self.headerLabel)
        
        self.addTransactionButton.addTarget(self, action: #selector(didTapAddTransaction(_:)), for: .touchUpInside)
        self.addIncomeButton.addTarget(self, action: #selector(didTapAddAmount(_:)), for: .touchUpInside)
      }
    
    @objc func didTapAddTransaction(_ sender: UIButton) {
        print("ADD")
        NotificationCenter.default.post(name: Notification.Name("toSpendingVC"), object: nil)
        
     }
    
    @objc func didTapAddAmount(_ sender: UIButton) {
        print("ADD child ")
          NotificationCenter.default.post(name: Notification.Name("toPopUpVC"), object: nil)
         //viewModel.btcAmount.value = "200"
        
     }
    
    func style(){
        self.backgroundColor = UIColor(named: "LightBlue")
        self.amountContainerView.backgroundColor = UIColor(named: "LightPastel")
        self.transactionsContainerView.backgroundColor = UIColor(named: "LightPastel")
        
        self.addTransactionButton.backgroundColor = UIColor(named: "LightGrey")
        self.addIncomeButton.backgroundColor = UIColor(named: "LightGrey")
        
        self.amountContainerView.layer.cornerRadius = 20.0
        self.transactionsContainerView.layer.cornerRadius = 20.0
        
        self.amountContainerView.clipsToBounds = true
        self.transactionsContainerView.clipsToBounds = true
        
        self.addTransactionButton.setTitle("+ Add Transaction", for: .normal)
         self.addTransactionButton.titleLabel?.font = UIFont(name: "OutlastSlab", size: 24.0)
        
        self.addTransactionButton.setTitleColor(.black, for: .normal)
        //self.addTransactionButton.tintColor = UIColor.black
        
        self.addTransactionButton.layer.cornerRadius = 10
        self.addTransactionButton.clipsToBounds = true
        
        self.addTransactionButton.configuration = .none
        
        self.addIncomeButton.setTitle("+ Add", for: .normal)
        self.addIncomeButton.titleLabel?.font = UIFont(name: "OutlastSlab", size: 24.0)
        
        self.addIncomeButton.setTitleColor(.black, for: .normal)
        
        self.addIncomeButton.layer.cornerRadius = 10
        self.addIncomeButton.clipsToBounds = true
        self.addIncomeButton.configuration = .none
        
        self.btcRateLabel.text = "1$ = 4154 BTC"
        self.btcRateLabel.textColor = .white
        self.btcRateLabel.font = UIFont(name: "OutlastSlab", size: 20.0)
        self.btcRateLabel.textAlignment = .right
        self.btcRateLabel.adjustsFontSizeToFitWidth = true
        
        
        self.btcAmountLabel.text = ""
        self.btcAmountLabel.textColor = UIColor(named: "DarkBlue")
        self.btcAmountLabel.font = UIFont(name: "OutlastSlab", size: 24.0)
        self.btcAmountLabel.textAlignment = .left
        self.btcAmountLabel.adjustsFontSizeToFitWidth = true
        
        self.headerLabel.text = "Transactions list"
        self.headerLabel.textColor = UIColor(named: "LightBlue")
        self.headerLabel.font = UIFont(name: "BRCobane-Medium", size: 20.0)
        self.headerLabel.textAlignment = .left
        self.headerLabel.adjustsFontSizeToFitWidth = true
        
        self.transactionsTableView.backgroundColor = .clear
        
        self.transactionsTableView.delegate = viewModel
        self.transactionsTableView.dataSource = viewModel
        self.transactionsTableView.backgroundColor = UIColor(named: "LightPastel")
        
        self.transactionsTableView.register(TransactionsTableViewCell.self, forCellReuseIdentifier: TransactionsTableViewCell.id)
        
        self.viewModel.updateBtcRate()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.viewModel.updateBtcAmount()
        }
    }
    
    func setupConstraints() {
        [
            amountContainerView,
            transactionsContainerView,
            btcRateLabel,
            btcAmountLabel,
            addIncomeButton,
            addTransactionButton,
            informationLabel,
            transactionsTableView,
            headerLabel
            ].forEach {
              $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            self.transactionsContainerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor , constant: -10),
            self.transactionsContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.transactionsContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.transactionsContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.56)
            
          ])
        
        
        NSLayoutConstraint.activate([
            self.amountContainerView.bottomAnchor.constraint(equalTo: self.transactionsContainerView.topAnchor , constant: -10),
            self.amountContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.amountContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.amountContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.28)
            
          ])
        
        NSLayoutConstraint.activate([
            self.addTransactionButton.bottomAnchor.constraint(equalTo: self.amountContainerView.bottomAnchor , constant: -10),
            self.addTransactionButton.leadingAnchor.constraint(equalTo: amountContainerView.leadingAnchor, constant: 10),
            self.addTransactionButton.trailingAnchor.constraint(equalTo: amountContainerView.trailingAnchor, constant: -10),
            self.addTransactionButton.heightAnchor.constraint(equalTo: amountContainerView.heightAnchor, multiplier: 0.18)
            
          ])
        
        NSLayoutConstraint.activate([
            self.addIncomeButton.topAnchor.constraint(equalTo: self.amountContainerView.topAnchor , constant: 10),
            // self.addIncomeButton.leadingAnchor.constraint(equalTo: amountContainerView.leadingAnchor, constant: 10),
            self.addIncomeButton.widthAnchor.constraint(equalTo: amountContainerView.widthAnchor, multiplier: 0.33),
            self.addIncomeButton.trailingAnchor.constraint(equalTo: amountContainerView.trailingAnchor, constant: -10),
            self.addIncomeButton.heightAnchor.constraint(equalTo: amountContainerView.heightAnchor, multiplier: 0.18)
            
          ])
        
        NSLayoutConstraint.activate([
            self.btcRateLabel.bottomAnchor.constraint(equalTo: self.amountContainerView.topAnchor , constant: -5),
            self.btcRateLabel.widthAnchor.constraint(equalTo: amountContainerView.widthAnchor, multiplier: 0.5),
            self.btcRateLabel.trailingAnchor.constraint(equalTo: amountContainerView.trailingAnchor, constant: 0),
            self.btcRateLabel.heightAnchor.constraint(equalTo: amountContainerView.heightAnchor, multiplier: 0.16)
            
          ])
        
        NSLayoutConstraint.activate([
            self.btcAmountLabel.topAnchor.constraint(equalTo: self.addIncomeButton.topAnchor , constant:0),
            self.btcAmountLabel.widthAnchor.constraint(equalTo: amountContainerView.widthAnchor, multiplier: 0.5),
            self.btcAmountLabel.leadingAnchor.constraint(equalTo: amountContainerView.leadingAnchor, constant: 10),
            self.btcAmountLabel.heightAnchor.constraint(equalTo: addIncomeButton.heightAnchor)
            
          ])
        
        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.transactionsContainerView.topAnchor , constant:0),
            self.headerLabel.leadingAnchor.constraint(equalTo: transactionsContainerView.leadingAnchor, constant: 10),
            self.headerLabel.trailingAnchor.constraint(equalTo: transactionsContainerView.trailingAnchor, constant: 10),
            self.headerLabel.heightAnchor.constraint(equalTo: self.transactionsContainerView.heightAnchor, multiplier: 0.11)

          ])
        
        NSLayoutConstraint.activate([
            self.transactionsTableView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor , constant:10),
            self.transactionsTableView.leadingAnchor.constraint(equalTo: transactionsContainerView.leadingAnchor, constant: 10),
            self.transactionsTableView.trailingAnchor.constraint(equalTo: transactionsContainerView.trailingAnchor, constant: -10),
            self.transactionsTableView.bottomAnchor.constraint(equalTo: self.transactionsContainerView.bottomAnchor, constant: -20)

          ])
    }
    
}

class ArchiveUtil {

    private static let PeopleKey = "PeopleKey"

    private static func archivePeople(people : [TransactionModel]) -> NSData {

        return NSKeyedArchiver.archivedData(withRootObject: people as NSArray) as NSData
    }

    static func loadPeople() -> [TransactionModel]? {

        if let unarchivedObject = UserDefaults.standard.object(forKey: PeopleKey) as? Data {

            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? [TransactionModel]
        }

        return nil
    }

    static func savePeople(people : [TransactionModel]?) {

        let archivedObject = archivePeople(people: people!)
        UserDefaults.standard.set(archivedObject, forKey: PeopleKey)
        UserDefaults.standard.synchronize()
    }

}
