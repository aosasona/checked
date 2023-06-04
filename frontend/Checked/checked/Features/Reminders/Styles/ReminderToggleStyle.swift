//
//  ReminderToggleStyle.swift
//  checked
//
//  Created by Ayodeji Osasona on 04/06/2023.
//

import SwiftUI

struct ReminderToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn
                  ? "largecircle.fill.circle"
                  : "circle")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(configuration.isOn ? .accentColor : .gray)
            .onTapGesture {
                configuration.isOn.toggle()
            }
            configuration.label
        }
    }
}

extension ToggleStyle where Self == ReminderToggleStyle {
    static var reminder: ReminderToggleStyle {
        ReminderToggleStyle()
    }
}

struct ReminderToggleStyle_Previews: PreviewProvider {
    struct Container: View {
        @State var isOn = true
        var body: some View {
            Toggle (isOn: $isOn) { Text("Hello") }
                .toggleStyle(.reminder)
        }
    }
    
    static var previews: some View {
       Container()
    }
}
