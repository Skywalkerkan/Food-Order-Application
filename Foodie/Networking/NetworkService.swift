//
//  NetworkService.swift
//  Foodie
//
//  Created by Erkan on 21.02.2023.
//

import Foundation

/// - Parameters:
///- route: the path of the resource in the backend
///- method: type of request to be made
///- parameters: whatever extra information you neet to pass to th backend
///- Returns: URL Request



struct NetworkService {
    
    
    //singleton
    static let shared = NetworkService()
    
    private init() {}
    
   /* func myFirstRequest(completion: @escaping(Result<[Dish], Error>) -> Void){
        request(route: .temp, method: .get, /*type: String.self,*/ completion: completion)
    }*/
    
    func fetchAllCategories(completion: @escaping(Result<AllDishes, Error>) -> Void){
        request(route: .fetchAllCategories, method: .get, completion: completion)
    }
    
    func placeOrder(dishId: String, name: String, completion: @escaping(Result<Order, Error>) -> Void){
        let params = [
            "name": name
        ]
        request(route: .placeOrder(dishId), method: .post, parameters: params, completion: completion)
    }
    func fetchCategoryDishes(categoryID: String, completion: @escaping(Result<[Dish],Error>) -> Void){
        request(route: .fetchCategoryDishes(categoryID), method: .get, completion: completion)
    }
    
    func fetchOrders(completion: @escaping(Result<[Order],Error>) -> Void){
        request(route: .fetchOrders, method: .get, completion: completion)
    }
    
    private func request<T: Decodable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     //type: T.Type,
                                     completion: @escaping (Result<T,Error>) -> Void){
        guard let request = createRequest(route: route, method: method, parameters: parameters) else{
            completion(.failure(AppError.unkownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data{
                result = .success(data)
                let responseString = String(data: data, encoding: .utf8) ?? "Could not stringify our data"
                print("the response is: \(responseString)")
            }else if let error = error{
                result = .failure(error)
                print("the error is: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {  // weak self olurdu class olsaydı
                // TODO decode our result and sende backk to the user
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
        
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?, completion: (Result<T,Error>) -> Void){
        guard let result = result else{
            completion(.failure(AppError.unkownError))
            return
        }
        switch result{
            
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else{
                completion(.failure(AppError.errorDecoding))
                return
            }
            if let error = response.error{
                completion(.failure(AppError.serverError(error)))
                return
            }
            if let decodedData = response.data{
                completion(.success(decodedData))
            }else{
                completion(.failure(AppError.unkownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
                                //endpoint  //get post delete
    private func createRequest(route: Route, method: Method, parameters: [String: Any]? = nil) -> URLRequest?{
        let urlString = (Route.baseUrl + route.description)
        guard let url = urlString.asUrl else{return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type") // ?????
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters{
            switch method{
                
            case .get:
                var urlComponent = URLComponents(string: urlString)
                                                   //MAPPİNG ? AND QUERY ITEMS
                urlComponent?.queryItems = params.map{URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData

            }
        }
        return urlRequest
    }
}
