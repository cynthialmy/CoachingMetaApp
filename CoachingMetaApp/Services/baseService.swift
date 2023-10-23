//
//  baseService.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 4/27/23.
//

import Foundation
import Alamofire
import Combine
import FirebaseAuth

class BaseService {
    let baseURL = "https://coachingmeta.herokuapp.com"
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    
    func makeRequest<T: Codable>(url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func dataToParameters(data: Data) -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return json as? [String: Any]
        } catch {
            print("Failed to convert data to parameters:", error)
            return nil
        }
    }
    
    func getUID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    public func getLoading() -> AnyPublisher<Bool, Never> {
        isLoading.eraseToAnyPublisher()
    }
}

extension Date {
    func toString(dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        return dateFormatter.string(from: self)
    }
}
