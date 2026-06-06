import Foundation

struct GiftRecommendation: Identifiable {
    let id             = UUID()
    let name:          String
    let description:   String
    let whyItWorks:    String
    let priceRange:    String
    let minPrice:      Int
    let maxPrice:      Int
    let emoji:         String
    let occasions:     [Occasion]
    let personalities: [Personality]
    let interests:     [Interest]
    let stages:        [RelationshipStage]
}
