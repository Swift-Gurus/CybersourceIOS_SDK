//
//  CybersourceRequest.swift
//  CybercourceSDK
//
//  Created by Alex Hmelevski on 2020-02-16.
//

import Foundation
import AHNetwork

struct CybersourceRequest: IRequest {
    let baseURL: String

    let path: String

    let parameters: [String: String]

    let headers: [String: String]

    let body: Data?

    let method: AHMethod

    let scheme: AHScheme

    let taskType: AHTaskType

    let port: Int?

    init(baseURL: String,
         path: String = "",
         parameters: [String: String] = [:],
         headers: [String: String],
         body: Data? = nil,
         method: AHMethod = .get,
         scheme: AHScheme = .https,
         taskType: AHTaskType = .request,
         port: Int? = nil) {
        self.baseURL = baseURL
        self.path = path
        self.headers = headers
        self.parameters = parameters
        self.body = body
        self.method = method
        self.scheme = scheme
        self.taskType = taskType
        self.port = port
    }

    func new(scheme: AHScheme) -> CybersourceRequest {
        return CybersourceRequest(baseURL: baseURL,
                               path: path,
                               parameters: parameters,
                               headers: headers,
                               body: body,
                               method: method,
                               scheme: scheme,
                               taskType: taskType,
                               port: port)
    }

    func appended(path: String) -> CybersourceRequest {
        return CybersourceRequest(baseURL: baseURL,
                               path: "\(self.path)\(path)",
                               parameters: parameters,
                               headers: headers,
                               body: body,
                               method: method,
                               scheme: scheme,
                               taskType: taskType,
                               port: port)
    }

    func new(baseURL: String) -> CybersourceRequest {
        return CybersourceRequest(baseURL: baseURL,
                                  path: path,
                                  parameters: parameters,
                                  headers: headers,
                                  body: body,
                                  method: method,
                                  scheme: scheme,
                                  taskType: taskType,
                                  port: port)
    }

    func new(body: Data) -> CybersourceRequest {
        return CybersourceRequest(baseURL: baseURL,
                                  path: path,
                                  parameters: parameters,
                                  headers: headers,
                                  body: body,
                                  method: method,
                                  scheme: scheme,
                                  taskType: taskType,
                                  port: port)
    }

    func new(method: AHMethod) -> CybersourceRequest {
          return CybersourceRequest(baseURL: baseURL,
                                    path: path,
                                    parameters: parameters,
                                    headers: headers,
                                    body: body,
                                    method: method,
                                    scheme: scheme,
                                    taskType: taskType,
                                    port: port)
    }

    func appending(headers: [String: String]) -> CybersourceRequest {
        var newHeaders = self.headers
        headers.forEach { (pair) in
            newHeaders[pair.key] = pair.value
        }

        return CybersourceRequest(baseURL: baseURL,
                                  path: path,
                                  parameters: parameters,
                                  headers: newHeaders,
                                  body: body,
                                  method: method,
                                  scheme: scheme,
                                  taskType: taskType,
                                  port: port)
    }
    
    
    
    init(from iRequest: IRequest) {
        self = CybersourceRequest(baseURL: iRequest.baseURL,
                                  path: iRequest.path,
                                  parameters: iRequest.parameters,
                                  headers: iRequest.headers,
                                  body: iRequest.body,
                                  method: iRequest.method,
                                  scheme: iRequest.scheme,
                                  taskType: iRequest.taskType,
                                  port: iRequest.port)
    }
    
}
