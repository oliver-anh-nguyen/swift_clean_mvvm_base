//
//  DefaultWeatherRepository.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 06/11/2022.
//

final class DefaultWeatherRepository {
    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultWeatherRepository: WeatherRepository {
    func fetchWeatherList(query: WeatherQuery, page: Int, cached: @escaping (WeatherPage) -> Void, completion: @escaping (Result<WeatherPage, Error>) -> Void) -> Cancellable? {
        let requestDTO = WeatherRequestDTO(q: query.query, cnt: 7, unit: "metric")
        let task = RepositoryTask()
        
        let endpoint = APIEndpoints.getWeather(with: requestDTO)
        task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        return task
        
    }
}
