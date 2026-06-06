import SwiftUI

struct ResultsView: View {

    let criteria: GiftCriteria

    @State private var selectedGift: GiftRecommendation?

    private var results: [GiftRecommendation] {
        GiftDatabase.recommendations(for: criteria)
    }

    var body: some View {
        Group {
            if results.isEmpty {
                emptyState
            } else {
                giftList
            }
        }
        .navigationTitle("Gift Ideas")
        .navigationBarTitleDisplayMode(.large)
        .sheet(item: $selectedGift) { gift in
            GiftDetailView(gift: gift)
        }
    }

    // MARK: - Gift List

    private var giftList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                summaryChips
                    .padding(.horizontal, 20)
                    .padding(.top, 4)

                Text("\(results.count) idea\(results.count == 1 ? "" : "s") found")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 20)

                LazyVStack(spacing: 14) {
                    ForEach(Array(results.enumerated()), id: \.element.id) { index, gift in
                        GiftCard(gift: gift, rank: index + 1)
                            .onTapGesture { selectedGift = gift }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
    }

    private var summaryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Chip(text: "\(criteria.occasion.emoji) \(criteria.occasion.rawValue)")
                Chip(text: "\(criteria.personality.emoji) \(criteria.personality.rawValue)")
                Chip(text: criteria.budget.rawValue)
                if !criteria.interests.isEmpty {
                    ForEach(Array(criteria.interests), id: \.id) { interest in
                        Chip(text: "\(interest.emoji) \(interest.rawValue)")
                    }
                }
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 20) {
            Text("🤔")
                .font(.system(size: 64))
            Text("No matches found")
                .font(.title2).fontWeight(.semibold)
            Text("Try adjusting your budget or criteria\nto see more options.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Gift Card

struct GiftCard: View {

    let gift: GiftRecommendation
    let rank: Int

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(
                        LinearGradient(
                            colors: [Color("AccentPink").opacity(0.15), Color("AccentPurple").opacity(0.10)],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 64, height: 64)
                Text(gift.emoji)
                    .font(.system(size: 32))
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(gift.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Spacer()
                    if rank <= 3 {
                        Text(rank == 1 ? "⭐ Top Pick" : rank == 2 ? "⭐ Great" : "👍 Good")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color("AccentPink"))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color("AccentPink").opacity(0.12))
                            .clipShape(Capsule())
                    }
                }

                Text(gift.priceRange)
                    .font(.subheadline)
                    .foregroundStyle(Color("AccentPurple"))
                    .fontWeight(.medium)

                Text(gift.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(Color(.separator).opacity(0.4), lineWidth: 0.5)
        )
    }
}

// MARK: - Chip

struct Chip: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.tertiarySystemBackground))
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(Color(.separator), lineWidth: 0.5)
            )
    }
}

#Preview {
    NavigationStack {
        ResultsView(criteria: GiftCriteria(
            occasion: .anniversary,
            personality: .foodie,
            interests: [.cooking, .travel],
            budget: .under150,
            relationshipStage: .longTerm
        ))
    }
}
