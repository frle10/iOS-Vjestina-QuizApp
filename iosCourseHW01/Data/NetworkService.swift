//
//  NetworkService.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 14.05.2021..
//
import Foundation

class NetworkService: NetworkServiceProtocol {
    
    private let baseUrl: String = "https://iosquiz.herokuapp.com/api"
    
    func login(email: String, password: String, callback: @escaping (LoginStatus) -> Void) {
        let url = URL(string: "\(baseUrl)/session?username=\(email)&password=\(password)")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        executeUrlRequest(request) { (result: Result<LoginResponse, RequestError>) in
            switch result {
            case .failure(_):
                callback(.error(400, "Bad Request"))
            case .success(let value):
                let defaults = UserDefaults.standard
                defaults.setValue(value.userId, forKey: "userId")
                defaults.setValue(value.token, forKey: "token")
                
                callback(.success)
            }
        }
    }
    
    func fetchQuizzes(token: String, callback: @escaping ([Quiz]) -> Void) {
        let url = URL(string: "\(baseUrl)/quizzes")
        
        var request = URLRequest(url: url!)
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        executeUrlRequest(request) { (result: Result<QuizzesResponse, RequestError>) in
            switch result {
            case .failure(_):
                callback([])
            case .success(let value):
                callback(value.quizzes)
            }
        }
    }
    
    func sendQuizResult(token: String, quizResult: QuizResult) {
        let url = URL(string: "\(baseUrl)/result")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        request.httpBody = try! JSONEncoder().encode(quizResult)
        
        executeUrlRequest(request) { (result: Result<String, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                print(value)
            }
        }
    }
    
    func fetchLeaderboardForQuiz(token: String, quizId: Int, callback: @escaping ([LeaderboardResult]) -> Void) {
        let url = URL(string: "\(baseUrl)/score?quiz_id=\(quizId)")
        
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        executeUrlRequest(request) { (result: Result<[LeaderboardResult], RequestError>) in
            switch result {
            case .failure(_):
                callback([])
            case .success(let value):
                callback(value)
            }
        }
    }
    
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping
(Result<T, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataDecodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
            
        }
        
        dataTask.resume()
    }
    
}
