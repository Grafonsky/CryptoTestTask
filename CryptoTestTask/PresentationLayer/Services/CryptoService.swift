//
//  CryptoService.swift
//  CryptoTestTask
//
//  Created by Bohdan Hawrylyshyn on 04.03.2022.
//

import Foundation

// MARK: - Protocol

protocol CryptoService {
    func getCryptoList(completion: @escaping ([CryptoEntity]) -> ())
    func getCryptoDetails(id: String, completion: @escaping (DetailedModel) -> ())
}

// MARK: - Implementation

final class CryptoServiceImp: CryptoService {
    
    // MARK: - Protocol funcs
    
    func getCryptoList(completion: @escaping ([CryptoEntity]) -> ()) {
        let sorting = ".market_cap_desc"
        let perPage = 20
        let page = 1
        
        let session: URLSession = URLSession.shared
        guard let url: URL = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=\(sorting)&per_page=\(perPage)&page=\(page)&sparkline=false") else { return }
        let request: URLRequest = URLRequest(url: url)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.global(qos: .background).async {
                guard let parsedData = self?.parseCoinsList(
                    data: data as NSData?,
                    response: response,
                    error: error as NSError?) else { return }
                completion(parsedData)
            }
        }
        task.resume()
    }
    
    func getCryptoDetails(id: String, completion: @escaping (DetailedModel) -> ()) {
        let session: URLSession = URLSession.shared
        guard let url: URL = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)") else { return }
        let request: URLRequest = URLRequest(url: url)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.global(qos: .background).async {
                guard let parsedData = self?.parseDetails(
                    data: data as NSData?,
                    response: response,
                    error: error as NSError?) else { return }
                completion(parsedData)
            }
        }
        task.resume()
    }
    
    // MARK: - Private funcs
    
    private func parseCoinsList(data: NSData?, response: URLResponse?, error: NSError?) -> [CryptoEntity]? {
        if error == nil && data != nil {
            let decoder = JSONDecoder()
            guard let unwrapData = data else { return nil }
            if let jsonData = try? decoder.decode([CryptoEntity].self, from: unwrapData as Data) {
                return jsonData
            }
        }
        return nil
    }
    
    private func parseDetails(data: NSData?, response: URLResponse?, error: NSError?) -> DetailedModel? {
        if error == nil && data != nil {
            let decoder = JSONDecoder()
            guard let unwrapData = data else { return nil }
            if let jsonData = try? decoder.decode(DetailedModel.self, from: unwrapData as Data) {
                return jsonData
            }
        }
        return nil
    }
}
