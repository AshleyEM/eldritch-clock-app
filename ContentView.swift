//
//  ContentView.swift
//  EldritchClock
//
//  Created by Ashley McLemore on 12/24/22.
//

import SwiftUI

struct ContentView: View {
    // things that update every second or by clicks
    @State var clockface : String = "clockface"
    @State var second = Calendar.current.component(.second, from:Date())
    @State var minute = Calendar.current.component(.minute, from:Date())
    @State var hour = Calendar.current.component(.hour, from:Date())

    //update every 1 second
    let timer = Timer.publish(every:1, on:.main, in:.common).autoconnect()
    var body: some View {

        Image(clockface)
            .overlay(
                Image("s_hand")
                    .rotationEffect(.degrees((6*Double(second))))
                    // prevent hand from snapping backwards when 59->0
                    .animation(second > 0 ? .easeInOut(duration:0.5) : .linear(duration:0), value:second)
                    .onReceive(timer){_ in
                        self.minute = Calendar.current.component(.minute, from:Date())
                        self.second = Calendar.current.component(.second, from:Date())
                    }
                    .position(x: 175, y: 164)
            )
            .overlay(
                Image("m_hand")
                    .rotationEffect(.degrees((6*Double(minute)) + 6*Double(second)/60), anchor:.center)
                    // prevent hand from snapping backwards when 59->0
                    .animation(minute > 0 ? .easeInOut(duration:1.0) : .linear(duration:0), value:minute)
                    .onReceive(timer){_ in
                        self.minute = Calendar.current.component(.minute, from:Date())
                        self.second = Calendar.current.component(.second, from:Date())
                    }
                    .position(x: 175, y: 335)
            )
            .overlay(
                Image("h_hand")
                    .rotationEffect(.degrees(30*Double(hour) + 30*Double(minute)/60), anchor:.center)
                    .animation(hour < 12 ? .easeInOut(duration:1.0) : .linear(duration:0), value:hour)
                    .onReceive(timer){_ in
                        self.hour = Calendar.current.component(.hour, from:Date())

                    }
                    .position(x: 175, y: 337)
            )
        // clock light button
            .overlay(
                Button(action:
                    {
                        if clockface == "clockface"{
                            clockface = "clockface_lit"
                        }else{
                            clockface = "clockface"
                        }
                    })
                {}
                .position(x:175,y:505)
                .
            )
        
       
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


