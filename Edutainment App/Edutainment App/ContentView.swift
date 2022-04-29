//
//  ContentView.swift
//  Edutainment App
//
//  Created by Jacek Yates on 4/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var questionChoice = 0
    @State private var numberChoice = 0
    
    let questionChoices = [5, 10, 20]
    
    var body: some View {
        NavigationView {
            ZStack {
                AngularGradient(gradient: Gradient(colors: [.blue, .yellow, .green, .red, .blue]), center: .center)
                    .ignoresSafeArea()
                VStack {
                    
                    
                    Text("Let's multiply!")
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                    
                    VStack(spacing: 15) {
                        VStack {
                            Text("Select your options")
                                .font(.headline.weight(.heavy))
                        }
                        
                        
                        Text("Number you want to multiply by")
                            .font(.headline)
                            .foregroundStyle(.tint)
                        
                        Stepper(numberChoice.formatted(), value: $numberChoice, in: 2...12, step: 1)
                            .padding(.leading)
                            .padding(.trailing)
                        
                        
                        Text("How many questions do you want to do?")
                            .font(.headline)
                            .foregroundStyle(.tint)
                        
                        Picker("Tip Percentage", selection: $questionChoice) {
                            ForEach(questionChoices, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                    
                    NavigationLink(destination: GameView(chosenMultiple: numberChoice, chosenQuestions: questionChoice)) {
                        Text("Start Game")
                    }
                    
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
