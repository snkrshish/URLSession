import Foundation

func getData(urlRequest: String) {

    let urlRequest = URL(string: urlRequest)
    guard let url = urlRequest else { return }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            print("Ошибка: \(error)")
        } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            print("Код ответа от сервера: \(response)")
        } else {
            print("Не получили ответ от сервера")
        }
    }.resume()
}
getData(urlRequest: "https://cat-fact.herokuapp.com/facts")
