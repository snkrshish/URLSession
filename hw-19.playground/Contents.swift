import Foundation
import CryptoKit

func getData(urlRequest: String) {

    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { 
        print("Неверный URL")
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Ошибка: \(error)")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("Код ответа от сервера: \(response)")
        } else {
            print("Не получили ответ от сервера")
        }

        if let data = data, let dataAsString = String(data: data, encoding: .utf8) {
            print(" Данные с сервера: \(dataAsString)")
        } else {
            print("Данные не могут быть загружены или конвертированы в текстовый формат")
        }

    }.resume()
}

let publicName = "e93ea0c2443eb860960961f770358c8c"
let privateName = "c2ad235cd913e96ab415fc4c174f8793b4a32bd1"
//let ts = NSDate().timeIntervalSince1970.description
let ts = "1"
let hash = "\(ts)\(privateName)\(publicName)".mb5()

var urlComponents = URLComponents()
urlComponents.scheme = "https"
urlComponents.host = "gateway.marvel.com"
urlComponents.path = "/v1/public/characters"
urlComponents.queryItems = [
    URLQueryItem(name: "ts", value: ts),
    URLQueryItem(name: "apikey", value: publicName),
    URLQueryItem(name: "hash", value: hash)
]

if let marvelURL = urlComponents.url {
    getData(urlRequest: marvelURL.absoluteString)
} else {
    print("Невозможно создать адрес")
}

getData(urlRequest: "https://cat-fact.herokuapp.com/facts")

extension String {
    func mb5() -> String {
            let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
            return computed.map { String(format: "%02hhx", $0) }.joined()
        }
}
