import SwiftUI

struct CriteriaSelectionView: View {

    @State private var criteria = GiftCriteria()
    @State private var step = 0
    @State private var navigateToResults = false

    private let totalSteps = 5

    var body: some View {
        VStack(spacing: 0) {
            progressBar
                .padding(.top, 8)
                .padding(.horizontal, 24)

            TabView(selection: $step) {
                occasionStep.tag(0)
                personalityStep.tag(1)
                interestsStep.tag(2)
                budgetStep.tag(3)
                stageStep.tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: step)

            navigationButtons
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
        }
        .navigationTitle(stepTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigateToResults) {
            ResultsView(criteria: criteria)
        }
    }

    // MARK: - Progress Bar

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(height: 6)
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: [Color("AccentPink"), Color("AccentPurple")],
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * CGFloat(step + 1) / CGFloat(totalSteps), height: 6)
                    .animation(.spring, value: step)
            }
        }
        .frame(height: 6)
        .padding(.bottom, 8)
    }

    private var stepTitle: String {
        switch step {
        case 0: return "The Occasion"
        case 1: return "Her Personality"
        case 2: return "Her Interests"
        case 3: return "Your Budget"
        case 4: return "Your Relationship"
        default: return ""
        }
    }

    // MARK: - Steps

    private var occasionStep: some View {
        StepScrollView(subtitle: "What's the reason for the gift?") {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                ForEach(Occasion.allCases) { occasion in
                    OptionCard(
                        emoji: occasion.emoji,
                        label: occasion.rawValue,
                        isSelected: criteria.occasion == occasion
                    ) {
                        criteria.occasion = occasion
                    }
                }
            }
        }
    }

    private var personalityStep: some View {
        StepScrollView(subtitle: "Which best describes her?") {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                ForEach(Personality.allCases) { personality in
                    OptionCard(
                        emoji: personality.emoji,
                        label: personality.rawValue,
                        isSelected: criteria.personality == personality
                    ) {
                        criteria.personality = personality
                    }
                }
            }
        }
    }

    private var interestsStep: some View {
        StepScrollView(subtitle: "Pick everything that applies (max 4)") {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                ForEach(Interest.allCases) { interest in
                    let selected = criteria.interests.contains(interest)
                    OptionCard(
                        emoji: interest.emoji,
                        label: interest.rawValue,
                        isSelected: selected
                    ) {
                        if selected {
                            criteria.interests.remove(interest)
                        } else if criteria.interests.count < 4 {
                            criteria.interests.insert(interest)
                        }
                    }
                }
            }
        }
    }

    private var budgetStep: some View {
        StepScrollView(subtitle: "How much are you looking to spend?") {
            VStack(spacing: 12) {
                ForEach(Budget.allCases) { budget in
                    BudgetRow(
                        budget: budget,
                        isSelected: criteria.budget == budget
                    ) {
                        criteria.budget = budget
                    }
                }
            }
        }
    }

    private var stageStep: some View {
        StepScrollView(subtitle: "Where are you two right now?") {
            VStack(spacing: 12) {
                ForEach(RelationshipStage.allCases) { stage in
                    BudgetRow(
                        emoji: stage.emoji,
                        label: stage.rawValue,
                        isSelected: criteria.relationshipStage == stage
                    ) {
                        criteria.relationshipStage = stage
                    }
                }
            }
        }
    }

    // MARK: - Navigation Buttons

    private var navigationButtons: some View {
        HStack(spacing: 12) {
            if step > 0 {
                Button {
                    step -= 1
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.headline)
                    .foregroundStyle(Color("AccentPink"))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color("AccentPink").opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }

            Button {
                if step < totalSteps - 1 {
                    step += 1
                } else {
                    navigateToResults = true
                }
            } label: {
                HStack(spacing: 6) {
                    Text(step == totalSteps - 1 ? "See Gifts" : "Next")
                        .font(.headline)
                    Image(systemName: step == totalSteps - 1 ? "gift" : "chevron.right")
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: [Color("AccentPink"), Color("AccentPurple")],
                        startPoint: .leading, endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
    }
}

// MARK: - Reusable Components

struct StepScrollView<Content: View>: View {
    let subtitle: String
    @ViewBuilder let content: () -> Content

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 24)
                    .padding(.top, 16)

                content()
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
            }
        }
    }
}

struct OptionCard: View {
    let emoji: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(emoji)
                    .font(.system(size: 32))
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? Color("AccentPink").opacity(0.12) : Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(
                                isSelected
                                    ? LinearGradient(colors: [Color("AccentPink"), Color("AccentPurple")], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    : LinearGradient(colors: [Color.clear], startPoint: .leading, endPoint: .trailing),
                                lineWidth: 2
                            )
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

struct BudgetRow: View {
    var emoji: String = "💰"
    let label: String
    let isSelected: Bool
    let action: () -> Void

    init(budget: Budget, isSelected: Bool, action: @escaping () -> Void) {
        self.label = budget.rawValue
        self.isSelected = isSelected
        self.action = action
    }

    init(emoji: String, label: String, isSelected: Bool, action: @escaping () -> Void) {
        self.emoji = emoji
        self.label = label
        self.isSelected = isSelected
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Text(emoji)
                    .font(.title2)
                Text(label)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(Color("AccentPink"))
                        .font(.title3)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? Color("AccentPink").opacity(0.10) : Color(.secondarySystemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? Color("AccentPink") : Color.clear, lineWidth: 2)
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        CriteriaSelectionView()
    }
}
