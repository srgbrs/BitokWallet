
import Foundation
import UIKit

class LoadingMainView: UIView {
    private var viewModel: LoadingViewModel
    
    private let name = UILabel()
    private let backgroundImg = UIImageView()
    
    init(viewModel: LoadingViewModel) {
       self.viewModel = viewModel
       
       super.init(frame: .zero)
       
       self.setup()
       self.style()

       self.setupConstraints()
     }
     
     required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
    
    func setup() {
        self.addSubview(self.name)
        self.addSubview(self.backgroundImg)
      }
    
    func style(){
        self.backgroundColor = .green
        
        self.name.textColor = .systemOrange
        self.name.font = .systemFont(ofSize: 18)
        self.name.text = "Ahri"
        self.name.textAlignment = .center
        
        self.backgroundImg.image = UIImage(named: "logo")
    }
    
    func setupConstraints() {
        
        [
              name,
              backgroundImg
            ].forEach {
              $0.translatesAutoresizingMaskIntoConstraints = false
            }
        
        NSLayoutConstraint.activate([
            self.name.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.name.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.name.heightAnchor.constraint(equalToConstant: 20.0),
            self.name.widthAnchor.constraint(equalToConstant: 100.0)
            
          ])
        
        NSLayoutConstraint.activate([

            self.backgroundImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.backgroundImg.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            self.backgroundImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.backgroundImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
            
          ])
    }
}
