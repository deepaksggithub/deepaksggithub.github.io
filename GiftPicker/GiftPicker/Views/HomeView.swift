import SwiftUI

struct HomeView: View {

    @State private var showCriteria = false
    @State private var floatOffset: CGFloat = 0

    var body: some View {
        ZStack {
            background

            VStack(spacing: 0) {
                Spacer()

                floatingEmojis
                    .offset(y: floatOffset)
                    .animation(
                        .easeInOut(duration: 3).repeatForever(autoreverses: true),
                        value: floatOffset
                    )

                Spacer().frame(height: 32)

                VStack(spacing: 16) {
                    Text("🎁")
                        .font(.system(size: 72))

                    Text("GiftPicker")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color("AccentPink"), Color("AccentPurple")],
                                startPoint: .leading, endPoint: .trailing
                            )
                        )

                    Text("Find the perfect gift for the\nwoman in your life.")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Spacer().frame(height: 48)

                Button {
                    showCriteria = true
                } label: {
                    HStack(spacing: 10) {
                        Text("Find Her Gift")
                            .font(.headline)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        LinearGradient(
                            colors: [Color("AccentPink"), Color("AccentPurple")],
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color("AccentPink").opacity(0.4), radius: 12, y: 6)
                }
                .padding(.horizontal, 32)

                Spacer()

                Text("Tailored suggestions based on who she is,\nnot just what's trending.")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 32)
            }
        }
        .navigationDestination(isPresented: $showCriteria) {
            CriteriaSelectionView()
        }
        .onAppear { floatOffset = -12 }
    }

    private var background: some View {
        Color(.systemBackground)
            .overlay(
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color("AccentPink").opacity(0.15), Color("AccentPurple").opacity(0.08)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 500, height: 500)
                    .offset(x: -120, y: -200)
            )
            .overlay(
                Circle()
                    .fill(Color("AccentPurple").opacity(0.08))
                    .frame(width: 400, height: 400)
                    .offset(x: 160, y: 300)
            )
            .ignoresSafeArea()
    }

    private var floatingEmojis: some View {
        HStack(spacing: 24) {
            ForEach(["💍", "🌹", "✨", "🎀"], id: \.self) { emoji in
                Text(emoji)
                    .font(.system(size: 28))
                    .opacity(0.7)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
