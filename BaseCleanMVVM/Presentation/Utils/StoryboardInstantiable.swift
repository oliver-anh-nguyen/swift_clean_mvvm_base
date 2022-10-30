//
//  StoryboardInstantiable.swift
//  BaseCleanMVVM
//
//  Created by AnhNguyen on 30/10/2022.
//

import Foundation
import UIKit

// The disadvantage of Associated Types is that it is quite difficult to access and can only be used in protocols

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {
    
    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyBoard = UIStoryboard(name: fileName, bundle: bundle)
        
        guard let vc  = storyBoard.instantiateInitialViewController() as? Self else {
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}

