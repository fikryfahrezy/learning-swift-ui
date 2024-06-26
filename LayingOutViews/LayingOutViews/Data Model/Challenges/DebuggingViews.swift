/*
 See the License.txt file for this sample’s licensing information.
 */

import SwiftUI

struct HalfCard: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "crown.fill")
                .font(.system(size: 80))
        }
        //#-learning-code-snippet(6.debugFrameCorrection)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay (alignment: .topLeading) {
            VStack {
                Image(systemName: "crown.fill")
                    .font(.body)
                Text("Q")
                    .font(.largeTitle)
                Image(systemName: "heart.fill")
                    .font(.title)
            }
            .padding()
        }
        //#-learning-code-snippet(6.debugFrameQuestion)
        //.border(Color.blue)
        //#-learning-code-snippet(6.debugFrame)
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        //.border(Color.green)
        //#-learning-code-snippet(6.debugBorder)
    }
}

struct DebuggingView: View {
    var body: some View {
        VStack {
            HalfCard()
            HalfCard()
                .rotationEffect(.degrees(180))
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black)
        )
        .aspectRatio(0.70, contentMode: .fit)
        .foregroundColor(.red)
        .padding()
    }
}

#Preview {
    DebuggingView()
}
