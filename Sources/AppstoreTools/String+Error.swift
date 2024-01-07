//
//  File.swift
//  
//
//  Created by James Wolfe on 04/01/2024.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { self }
}
