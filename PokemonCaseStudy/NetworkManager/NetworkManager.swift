//
//  NetworkManager.swift
//  PokemonCaseStudy
//
//  Created by Mustafa on 7.12.2022.
//

import Foundation
 
class NetworkManager {
 
    enum ManagerErrors: Error {
        case invalidResponse
        case invalidStatusCode(Int)
    }
    
    private let baseURL : String = StringConstants.instance.BASE_URL;
    

  
    func request<T: Decodable>(path : NetworkRoutes, httpMethod: HttpMethods = .get, params : String?, token : String?, httpBody: Codable?,completion: @escaping (Result<T, Error>) -> Void) {
         

         let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        guard let url = URL(string: "\(baseURL)\(path.rawValue)\(params ?? "")") else { fatalError("Invalid URL") }
        print(url);
        var request = URLRequest(url: url)
        
        if token != nil && token != ""{
            request.setValue("Authorization", forHTTPHeaderField: token!);
        }
        
        request.httpMethod = httpMethod.rawValue
        
      
        do {
            if httpBody != nil {
                let rawHttpBody = try JSONEncoder().encode(httpBody!.self)
                request.httpBody = rawHttpBody;
            }
        }catch{
            print("JSON ENCODE FAILED");
        }
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
           
            if let error = error {
                completionOnMain(.failure(error))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(response))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
        urlSession.resume()
    }
}
