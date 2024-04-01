//
//  Login.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 3/31/24.
//

import SwiftUI

struct Login: View {
    var body: some View {
        VStack{
            HStack {
                Text("Sleep Tracer")
                    .font(
//                        .custom("AppleSDGothicNeo-Light", fixedSize: 64)
                        .custom("ArialHebrew-Light", fixedSize: 64)
//                        .weight(.bold)
                    )
                    .foregroundStyle(.cyan)
                
                Spacer()
                Image("Sleep Tracer Icon")

            }
            Spacer()
        }
        .background(Color.black)
    }
}

#Preview {
    Login()
}
