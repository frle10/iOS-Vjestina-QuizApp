//
//  Result.swift
//  iosCourseHW01
//
//  Created by Ivan Skorupan on 15.05.2021..
//

import Foundation

enum Result<Success, Failure> where Failure : Error {
    
    /// A success, storing a `Success` value.
    case success(Success)
    
    /// A failure, storing a `Failure` value.
    case failure(Failure)
    
}
