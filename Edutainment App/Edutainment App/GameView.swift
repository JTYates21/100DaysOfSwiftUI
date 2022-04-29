//
//  GameView.swift
//  Edutainment App
//
//  Created by Jacek Yates on 4/28/22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State private var questionCounter = 0
    @State private var showingResults = false
    @State private var showingScore = false
    
    @State private var randomNumber = Int.random(in: 0..<13)
    @State private var playerAnswer: Int?
    @FocusState var isFocused: Bool
    
    @State private var scoreTitle = ""
    @State private var score = 0
    
    let chosenMultiple: Int
    let chosenQuestions: Int
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.blue, .yellow, .green, .red, .blue]), center: .center)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("What is \(chosenMultiple) multiplied by \(randomNumber)?")
                            .font(.title)
                        
                        TextField("Enter your answer", value: $playerAnswer, format: .number)
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .focused($isFocused)
                        
                        Button("Submit", action: multiply)
                            .buttonStyle(.borderedProminent)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Score \(score)/\(chosenQuestions)")
                
                Spacer()
                
            }
            .toolbar {
                Button("New Game", action: newGame)
            }
            .padding()
            
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: newQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            
            .alert("Game Over!", isPresented: $showingResults) {
                Button("Continue", action: {
                    self.mode.wrappedValue.dismiss()
                })
            } message: {
                Text("Your final score is \(score)/\(chosenQuestions)")
            }
        }
    }
    
    
    func multiply() {
        let correctAnswer = chosenMultiple * randomNumber
        
        if playerAnswer == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            questionCounter += 1
        } else {
            scoreTitle = "Wrong, the correct answer is \(correctAnswer)"
            score -= 1
            questionCounter += 1
        }
        
        if questionCounter == chosenQuestions {
            showingResults = true
        } else {
            showingScore = true
        }
    }
    
    func newQuestion() {
        randomNumber = Int.random(in: 0..<13)
        isFocused = false
        playerAnswer = nil
    }
    
    func newGame() {
        questionCounter = 0
        score = 0
        self.mode.wrappedValue.dismiss()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(chosenMultiple: 2, chosenQuestions: 5)
    }
}
