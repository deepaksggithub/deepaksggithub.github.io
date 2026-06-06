import Foundation

enum Occasion: String, CaseIterable, Identifiable {
    case birthday    = "Birthday"
    case anniversary = "Anniversary"
    case valentines  = "Valentine's Day"
    case christmas   = "Christmas"
    case justBecause = "Just Because"
    case motherDay   = "Mother's Day"
    case graduation  = "Graduation"

    var id: String { rawValue }
    var emoji: String {
        switch self {
        case .birthday:    return "🎂"
        case .anniversary: return "💑"
        case .valentines:  return "❤️"
        case .christmas:   return "🎄"
        case .justBecause: return "🎁"
        case .motherDay:   return "🌸"
        case .graduation:  return "🎓"
        }
    }
}

enum Personality: String, CaseIterable, Identifiable {
    case adventurous  = "Adventurous"
    case creative     = "Creative"
    case homebody     = "Homebody"
    case fashionista  = "Fashionista"
    case foodie       = "Foodie"
    case intellectual = "Intellectual"
    case wellness     = "Wellness"
    case social       = "Social Butterfly"

    var id: String { rawValue }
    var emoji: String {
        switch self {
        case .adventurous:  return "🏔️"
        case .creative:     return "🎨"
        case .homebody:     return "🏠"
        case .fashionista:  return "👗"
        case .foodie:       return "🍽️"
        case .intellectual: return "📚"
        case .wellness:     return "🧘"
        case .social:       return "🥂"
        }
    }
}

enum Interest: String, CaseIterable, Identifiable {
    case reading   = "Reading"
    case cooking   = "Cooking"
    case fitness   = "Fitness"
    case travel    = "Travel"
    case art       = "Art & Crafts"
    case music     = "Music"
    case beauty    = "Beauty"
    case tech      = "Tech"
    case gardening = "Gardening"
    case movies    = "Movies & TV"
    case yoga      = "Yoga"
    case fashion   = "Fashion"

    var id: String { rawValue }
    var emoji: String {
        switch self {
        case .reading:   return "📖"
        case .cooking:   return "👩‍🍳"
        case .fitness:   return "🏋️"
        case .travel:    return "✈️"
        case .art:       return "🎨"
        case .music:     return "🎵"
        case .beauty:    return "💄"
        case .tech:      return "💻"
        case .gardening: return "🌱"
        case .movies:    return "🎬"
        case .yoga:      return "🧘"
        case .fashion:   return "👠"
        }
    }
}

enum Budget: String, CaseIterable, Identifiable {
    case under25  = "Under $25"
    case under75  = "$25 – $75"
    case under150 = "$75 – $150"
    case under500 = "$150 – $500"
    case luxury   = "$500+"

    var id: String { rawValue }
    var minValue: Int {
        switch self {
        case .under25:  return 0
        case .under75:  return 25
        case .under150: return 75
        case .under500: return 150
        case .luxury:   return 500
        }
    }
    var maxValue: Int {
        switch self {
        case .under25:  return 25
        case .under75:  return 75
        case .under150: return 150
        case .under500: return 500
        case .luxury:   return 10_000
        }
    }
}

enum RelationshipStage: String, CaseIterable, Identifiable {
    case new         = "New (< 1 year)"
    case established = "1–3 Years"
    case longTerm    = "Long-term / Married"

    var id: String { rawValue }
    var emoji: String {
        switch self {
        case .new:         return "🌱"
        case .established: return "💛"
        case .longTerm:    return "💍"
        }
    }
}

struct GiftCriteria {
    var occasion:          Occasion          = .birthday
    var personality:       Personality       = .creative
    var interests:         Set<Interest>     = []
    var budget:            Budget            = .under75
    var relationshipStage: RelationshipStage = .established
}
