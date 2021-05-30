//
//  RequestError.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 15.05.2021..
//

import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case dataDecodingError
}
