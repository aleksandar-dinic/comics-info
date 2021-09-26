//
//  DescriptionView.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI

struct DescriptionView: View {

    let description: String

    var body: some View {
        VStack {
            Text("Description")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Divider()
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.body)
        }
        .padding()
        .accessibility(identifier: "DescriptionView")
    }

}

#if DEBUG
struct DescriptionView_Previews: PreviewProvider {

    static let description = """
        With the Parker household desperate for money following the death of Ben Parker, Peter Parker \
        decides to continue in show business as Spider-Man. However, not only does he find it impossible \
        to cash his paycheck (made out to Spider-Man), but the irrational editorials by J. Jonah Jameson \
        in the Daily Bugle effectively quelch his career. Besides denouncing Spider-Man as a \
        publicity-seeking phony, J. Jonah Jameson also publishes articles lauding his son, John Jameson, \
        a courageous astronaut about to be launched into orbit in a space capsule. J. Jonah Jameson calls \
        his son a "real hero."
        """

    static var previews: some View {
        DescriptionView(description: description)
            .padding()
            .previewLayout(.sizeThatFits)
    }

}
#endif
