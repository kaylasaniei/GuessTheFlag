//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by xSyl on 7/21/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in:0...2)
    @State private var score = 0
    @State private var question = " "
    @State private var showingQuestionNum = false
    @State private var questionNum = 0
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess! The! Flag! ")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of...")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius:20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Text("Question Number: \(questionNum)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(question, isPresented: $showingQuestionNum) {
            Button("Restart", action: reset)
        }
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        questionNum += 1
        if questionNum == 5 {
            showingQuestionNum = true
            question = "\(score)/\(questionNum) correct"
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in:0...2)
    }
    func reset() {
        score = 0
        questionNum = 0
    }
}

#Preview {
    ContentView()
}


