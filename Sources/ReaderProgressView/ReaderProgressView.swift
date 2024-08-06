//
//  File.swift
//  
//
//  Created by Mohamed Arradi on 05/08/2024.
//

import Foundation
import UIKit
import SwiftUI

public struct ReaderProgressView: UIViewRepresentable {
    @Binding var progress: CGFloat
    @State var trackColor: Color
    @State var progressColor: Color
    @State var spaceBetweenBars: CGFloat
    
    public init(progress: Binding<CGFloat>, trackColor: Color, progressColor: Color, spaceBetweenBars: CGFloat) {
        self._progress = progress
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.spaceBetweenBars = spaceBetweenBars
    }
    
    public func makeUIView(context: Context) -> UIKProgressBar {
        let progressBar = UIKProgressBar()
        progressBar.progress = progress
        progressBar.progressColor = progressColor
        progressBar.trackColor = trackColor
        progressBar.spaceBetweenBars = spaceBetweenBars
        return progressBar
    }
    public func updateUIView(_ uiView: UIKProgressBar, context: Context) {
        uiView.progress = progress
    }
}

fileprivate struct ContentView: View {
    @State private var progress: CGFloat = 0.5

    var body: some View {
        VStack {
            ReaderProgressView(progress: $progress,
                               trackColor: .gray.opacity(0.3),
                               progressColor: .blue.opacity(0.9), 
                               spaceBetweenBars: 8.0)
                .frame(height: 10)
                .padding()

            Button(action: {
                // Update progress for demonstration
                withAnimation {
                    progress = min(progress + 0.1, 1.0)
                }
            }) {
                Text("Increase Progress")
            }
            
            Button(action: {
                // Update progress for demonstration
                withAnimation {
                    if progress >= 0 {
                        progress = min(progress - 0.1, 1.0)
                    }
                }
            }) {
                Text("Decrease Progress")
            }
        }
    }
}

struct ReaderProgressView_Previews: PreviewProvider {
    @State static var progress: CGFloat = 0.5
    @State private var progress: CGFloat = 0.5

    static var previews: some View {
        ContentView()
    }
}
