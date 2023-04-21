//
//  DetailColorView.swift
//  MyColorMaker
//
//  Created by user on 2023/04/20.
//

import SwiftUI

struct DetailColorView: View {
    var color: Colors
    var body: some View {
        List {
            Section("My color!") {
                VStack(alignment: .center) {
                    if color.image != nil {
                        Image(uiImage: UIImage(data: color.image!)!)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 200, height: 200)
                

                    
                    // dominat color & color picker
                HStack {
                    Rectangle()
                        .fill(Color(color.color))
                        .frame(width: 200, height: 200)
                    VStack(alignment: .leading) {
                        Text("Red: \(color.color.getRGBA().0)")
                            .padding()
                        Text("Green: \(color.color.getRGBA().1)")
                            .padding()
                        
                        Text("Blue: \(color.color.getRGBA().2)")
                            .padding()
                        
                        Text("Opacity: \(color.color.getRGBA().3)")
                            .padding()
                    }
                }
            }
            
            Section("Hex code") {
                Text("#\(color.color.toHexString())")
                    .padding()
            }
            
            Section("Color's Birthday🥳") {
                Text(String(color.date.get(.year))+".\(color.date.get(.month)).\(color.date.get(.day))")
                    .padding()
            }
        }
    }
}

//struct DetailColorView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailColorView()
//    }
//}
