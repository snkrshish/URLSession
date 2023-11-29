import Foundation

func getData(urlRequest: String) {

    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Ошибка: \(error)")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
        }
    }.resume()
}
getData(urlRequest: "https://cat-fact.herokuapp.com/facts")
