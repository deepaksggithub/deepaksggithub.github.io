import SwiftUI

struct GiftDetailView: View {

    let gift: GiftRecommendation
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    header
                    content
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color(.systemGray3))
                            .font(.title2)
                    }
                }
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color("AccentPink").opacity(0.2), Color("AccentPurple").opacity(0.15)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                Text(gift.emoji)
                    .font(.system(size: 60))
            }

            Text(gift.name)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(gift.priceRange)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(
                    LinearGradient(
                        colors: [Color("AccentPink"), Color("AccentPurple")],
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .padding(.horizontal, 24)
        .background(
            LinearGradient(
                colors: [Color("AccentPink").opacity(0.06), Color(.systemBackground)],
                startPoint: .top, endPoint: .bottom
            )
        )
    }

    // MARK: - Content

    private var content: some View {
        VStack(spacing: 20) {
            InfoSection(icon: "heart.fill", title: "Why It Works", color: Color("AccentPink")) {
                Text(gift.whyItWorks)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            InfoSection(icon: "text.alignleft", title: "About This Gift", color: Color("AccentPurple")) {
                Text(gift.description)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            InfoSection(icon: "tag.fill", title: "Best For", color: .orange) {
                occasionTags
            }

            shareButton
        }
        .padding(20)
    }

    private var occasionTags: some View {
        FlowLayout(spacing: 8) {
            ForEach(gift.occasions, id: \.id) { occasion in
                TagPill(text: "\(occasion.emoji) \(occasion.rawValue)", color: Color("AccentPink"))
            }
            ForEach(gift.personalities, id: \.id) { personality in
                TagPill(text: "\(personality.emoji) \(personality.rawValue)", color: Color("AccentPurple"))
            }
        }
    }

    private var shareButton: some View {
        ShareLink(
            item: "Gift idea: \(gift.name) (\(gift.priceRange)) — \(gift.description)",
            subject: Text("Gift Idea"),
            message: Text("Found this on GiftPicker: \(gift.name)")
        ) {
            HStack(spacing: 8) {
                Image(systemName: "square.and.arrow.up")
                Text("Share This Idea")
                    .fontWeight(.semibold)
            }
            .foregroundStyle(Color("AccentPink"))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color("AccentPink").opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.bottom, 8)
    }
}

// MARK: - Info Section

struct InfoSection<Content: View>: View {
    let icon: String
    let title: String
    let color: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundStyle(color)
                Text(title)
                    .font(.headline)
            }
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

// MARK: - Tag Pill

struct TagPill: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color.opacity(0.12))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

// MARK: - Flow Layout

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? 0
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0

        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if currentX + size.width > maxWidth, currentX > 0 {
                currentX = 0
                currentY += rowHeight + spacing
                rowHeight = 0
            }
            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
        return CGSize(width: maxWidth, height: currentY + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentX = bounds.minX
        var currentY = bounds.minY
        var rowHeight: CGFloat = 0

        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if currentX + size.width > bounds.maxX, currentX > bounds.minX {
                currentX = bounds.minX
                currentY += rowHeight + spacing
                rowHeight = 0
            }
            view.place(at: CGPoint(x: currentX, y: currentY), proposal: ProposedViewSize(size))
            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

#Preview {
    GiftDetailView(gift: GiftDatabase.allGifts[0])
}
