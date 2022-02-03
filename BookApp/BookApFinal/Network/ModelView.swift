import Foundation

enum Error {
    case parse
    case unknown(String)
    
    var message: String {
        switch self {
        case .parse:
            return "Parse error. Please try later"
        case .unknown(let description):
            return description
        }
    }
}

class NetworkManager {
    func getBook(completion: @escaping ([Item]) -> Void) {
        
        let fullUrlStr = "https://www.googleapis.com/books/v1/volumes?q=programming"
        
        if let urlStr = fullUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlStr) {
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    _ = error.localizedDescription
                } else if let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = data {
                    do {
                        let json = String(data: data, encoding: .utf8)!
                        let jsonData = json.data(using: .utf8)!
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let launch = try decoder.decode(Book.self, from: jsonData)
                        let items = launch.items
                        completion(items)
                    } catch _ {}
                }
            }
            dataTask.resume()
        }
    }
}

// Also must be chacked network connection(internet/wifi) & error messages if smth went wrong
//in loading process, but you didn't asked me about it

