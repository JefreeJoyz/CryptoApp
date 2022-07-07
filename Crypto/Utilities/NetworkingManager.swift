//
//  NetworkingManager.swift
//  Crypto
//
//  Created by Eugene Yakushev on 22.06.2022.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[💩] Bad response from URL. \(url)"
                case .unknown: return "[🔥] unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
       //let temp = - что бы посмотреть, какой тип надо вернуть, присваиваем переменной URLSession и option+click по переменной
        // после этого - добавляем .eraseToAnyPublisher() и копируем из ошибки требуемый возвращаемый тип
        return URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default))  -- закомменчено, ибо процесс идет в беграунде по дефолту
            .tryMap({ try handleUrlResponse(output: $0, url: url) })
            //.receive(on: DispatchQueue.main) -- закомменчено, ибо эта функция возвращала в мейн тред, а в других (использующих ее) потом был декодинг джейсон даты. Поэтому здесь мы убрали мейн тред, а в вызывающих ее функциях после (!) декодинга - указали мейн тред
            .retry(3) // если handleUrlResponse зайфейлиться - будем пытаться еще раз (до 3х раз)
            .eraseToAnyPublisher()
    }
    
    static func handleUrlResponse (output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription )
        }
    }
}
