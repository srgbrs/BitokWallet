import Foundation

 // (Facade pattern)
class NetworkServices {
    lazy var networkQuery =  NetworkQuery()
    
}

class NetworkQuery {
    var rate : Int = 0
    init() {
       
    }

    public func decodeAPI(completionHandler : @escaping (_ rate: Int) -> ()){
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else{return}

        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()

            if let data = data{
                do{
                    let tasks = try decoder.decode(RateModel.self, from: data)
                    self.rate = Int(tasks.bpi.USD.rate_float)
                    completionHandler(Int(tasks.bpi.USD.rate_float))
                }catch{
                    print(error)
                }
            }
        }
        task.resume()

    }
}
