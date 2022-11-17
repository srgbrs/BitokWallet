import UIKit

class TransactionsTableViewCell: UITableViewCell {
    
    static var id: String = "Cell"
    
    // var name = UILabel()
    var dateLabel = UILabel()
    var categoryLabel = UILabel()
    var amountLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellStyle() {
        self.selectionStyle = .none
        
        [dateLabel,categoryLabel,amountLabel].forEach({
            $0.font = UIFont(name: "BRCobane-Medium", size: 16.0)
            $0.textAlignment = .center
        })
        
        dateLabel.textColor = UIColor(named: "DarkBlue")
    }
    
    override func layoutSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(amountLabel)

        setupCellStyle()
        
        [
            categoryLabel,
            dateLabel,
            amountLabel
            ].forEach {
              $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            dateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 10),
            categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
        NSLayoutConstraint.activate([
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            amountLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            amountLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
    

}
