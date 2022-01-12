//
//  LoadableObject.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/12/2021.
//

import Foundation

protocol LoadableObject: ObservableObject {
 
    associatedtype Output
    var state: LoadingState<Output> { get }

}

extension LoadableObject {
    
    var isLoading: Bool {
        state.isLoading()
    }
    
    func isInputDisabled() -> Bool {
        isLoading
    }
    
    var alertMessage: String {
        state.errorMessage
    }
    
}
