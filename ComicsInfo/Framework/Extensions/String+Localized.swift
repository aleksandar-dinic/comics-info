//
//  String+Localized.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 27/12/2021.
//

import Foundation

extension String {
    
    static func localized(_ authError: AuthError) -> String {
        NSLocalizedString(
            authError.key,
            value: authError.value,
            comment: authError.comment
        )
    }
    
}
