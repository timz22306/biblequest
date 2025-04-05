import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = QuestionViewModel()
    
    var body: some View {
        NavigationStack {
            if viewModel.showingResults {
                resultsView
            } else {
                questionView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary.opacity(0.05)) // Using SwiftUI native colors
    }
    
    var questionView: some View {
        VStack(spacing: 24) {
            // Progress bar
            ProgressView(value: viewModel.progressValue)
                .tint(Color.blue)
                .padding(.horizontal)
                .scaleEffect(x: 1, y: 1.5, anchor: .center)
            
            // Question counter
            Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                .font(.headline)
                .foregroundColor(.secondary)
            
            // Question text
            Text(viewModel.currentQuestion.text)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            
            Spacer(minLength: 10)
            
            // Answer options
            VStack(spacing: 14) {
                ForEach(0..<viewModel.currentQuestion.options.count, id: \.self) { index in
                    Button(action: {
                        viewModel.selectAnswer(index)
                    }) {
                        Text(viewModel.currentQuestion.options[index])
                            .font(.system(size: 16, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.blue.opacity(0.1))
                                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                            )
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Question Bank")
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var resultsView: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 16) {
                    Text("Quiz Complete!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Your score: \(viewModel.score) out of \(viewModel.questions.count)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    // Score circle
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 15)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(viewModel.score) / CGFloat(viewModel.questions.count))
                            .stroke(
                                viewModel.score > viewModel.questions.count / 2 ? Color.green : Color.orange,
                                style: StrokeStyle(lineWidth: 15, lineCap: .round)
                            )
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                        
                        Text("\(Int((Double(viewModel.score) / Double(viewModel.questions.count)) * 100))%")
                            .font(.system(size: 36, weight: .bold))
                    }
                    .padding(.vertical)
                }
                
                // Question results
                VStack(alignment: .leading, spacing: 16) {
                    Text("Question Summary")
                        .font(.headline)
                        .padding(.leading)
                    
                    ForEach(viewModel.questions) { question in
                        HStack(alignment: .top) {
                            if question.isAnsweredCorrectly == true {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 20))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 20))
                            }
                            
                            Text(question.text)
                                .fontWeight(.medium)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.1)) // Using SwiftUI native colors
                        )
                        .padding(.horizontal)
                    }
                }
                
                // Restart button
                Button(action: {
                    viewModel.restartQuiz()
                }) {
                    Text("Restart Quiz")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            .padding(.vertical)
        }
        .navigationTitle("Results")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
