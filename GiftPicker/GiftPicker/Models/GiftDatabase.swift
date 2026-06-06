import Foundation

enum GiftDatabase {

    static func recommendations(for criteria: GiftCriteria) -> [GiftRecommendation] {
        let budgetMatches = allGifts.filter { gift in
            gift.minPrice <= criteria.budget.maxValue &&
            gift.maxPrice >= criteria.budget.minValue
        }

        let scored: [(GiftRecommendation, Int)] = budgetMatches.map { gift in
            var score = 0
            if gift.occasions.contains(criteria.occasion)               { score += 3 }
            if gift.personalities.contains(criteria.personality)        { score += 2 }
            let shared = Set(gift.interests).intersection(criteria.interests)
            score += shared.count * 2
            if gift.stages.contains(criteria.relationshipStage)         { score += 1 }
            return (gift, score)
        }

        return scored
            .filter { $0.1 > 0 }
            .sorted { $0.1 > $1.1 }
            .map { $0.0 }
    }

    // MARK: - Gift Catalog

    static let allGifts: [GiftRecommendation] = [

        GiftRecommendation(
            name: "Spa Day Experience",
            description: "A full day at a luxury spa — massage, facial, and relaxation treatments. A gift she can truly sink into.",
            whyItWorks: "Shows you want her to feel pampered and valued. One of the most universally appreciated gifts for any occasion.",
            priceRange: "$100 – $200",
            minPrice: 100, maxPrice: 200,
            emoji: "🛁",
            occasions: [.birthday, .anniversary, .valentines, .motherDay],
            personalities: [.wellness, .homebody, .fashionista],
            interests: [.yoga, .beauty],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Personalized Name Necklace",
            description: "A delicate gold or silver necklace engraved with her name or initials. Timeless and deeply personal.",
            whyItWorks: "Jewelry with a personal touch says you put thought into it. She'll wear it every day and think of you.",
            priceRange: "$40 – $120",
            minPrice: 40, maxPrice: 120,
            emoji: "📿",
            occasions: [.birthday, .anniversary, .valentines, .graduation],
            personalities: [.fashionista, .creative],
            interests: [.fashion, .beauty],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Cooking Class for Two",
            description: "An in-person or virtual cooking class where you learn a new cuisine together — Italian, sushi, French pastry, and more.",
            whyItWorks: "A shared experience creates a lasting memory. Doubles as a fun date night she didn't have to plan.",
            priceRange: "$80 – $160",
            minPrice: 80, maxPrice: 160,
            emoji: "👩‍🍳",
            occasions: [.anniversary, .valentines, .justBecause, .birthday],
            personalities: [.foodie, .social, .adventurous, .creative],
            interests: [.cooking],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Luxury Perfume",
            description: "A high-end fragrance from a renowned house — Chanel, Maison Margiela, Jo Malone, or her favourite brand.",
            whyItWorks: "Scent is deeply tied to memory. Giving a perfume says you notice and appreciate the small details about her.",
            priceRange: "$80 – $200",
            minPrice: 80, maxPrice: 200,
            emoji: "🌹",
            occasions: [.birthday, .valentines, .christmas, .anniversary],
            personalities: [.fashionista, .wellness, .homebody],
            interests: [.beauty, .fashion],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Weekend Getaway",
            description: "A surprise mini-trip to a nearby city, a cozy cabin, a beach town, or wherever she's been wanting to go.",
            whyItWorks: "A trip together is the gift of undivided time and adventure. Perfect when you want to go big and make a real memory.",
            priceRange: "$300 – $1,000+",
            minPrice: 300, maxPrice: 1500,
            emoji: "✈️",
            occasions: [.anniversary, .birthday, .valentines, .justBecause],
            personalities: [.adventurous, .social],
            interests: [.travel],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Premium Skincare Set",
            description: "A curated skincare routine — cleanser, serum, moisturiser, and eye cream from a brand she loves or has been eyeing.",
            whyItWorks: "Skincare is self-care. It shows you've been paying attention to what she puts on her skin.",
            priceRange: "$60 – $200",
            minPrice: 60, maxPrice: 200,
            emoji: "✨",
            occasions: [.birthday, .christmas, .motherDay, .justBecause],
            personalities: [.wellness, .fashionista, .homebody],
            interests: [.beauty, .yoga],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Kindle Paperwhite",
            description: "The best e-reader on the market — lightweight, waterproof, and holds thousands of books. Pair it with a gift card.",
            whyItWorks: "For a woman who loves to read, this is life-changing. She can carry her entire library in her bag.",
            priceRange: "$130 – $180",
            minPrice: 130, maxPrice: 180,
            emoji: "📚",
            occasions: [.birthday, .christmas, .graduation],
            personalities: [.intellectual, .homebody],
            interests: [.reading],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Yoga Mat & Accessories Bundle",
            description: "A premium non-slip yoga mat, a yoga block, a strap, and a tote bag — everything she needs for the perfect practice.",
            whyItWorks: "Practical and thoughtful. If she's into yoga or wellness, quality gear makes every session better.",
            priceRange: "$50 – $120",
            minPrice: 50, maxPrice: 120,
            emoji: "🧘",
            occasions: [.birthday, .justBecause, .christmas],
            personalities: [.wellness, .adventurous],
            interests: [.yoga, .fitness],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Watercolor Painting Kit",
            description: "A high-quality watercolor set with brushes, a sketchbook, and palette — beautifully packaged for the creative soul.",
            whyItWorks: "Gives her a creative outlet she can return to again and again. Every painting she makes will remind her of you.",
            priceRange: "$30 – $80",
            minPrice: 30, maxPrice: 80,
            emoji: "🎨",
            occasions: [.birthday, .christmas, .justBecause],
            personalities: [.creative],
            interests: [.art],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Silk Robe",
            description: "A luxuriously soft silk or satin robe — the kind she'd never buy for herself but will wear every single morning.",
            whyItWorks: "Indulgent and intimate. Perfect for a partner you want to feel spoiled at home.",
            priceRange: "$60 – $160",
            minPrice: 60, maxPrice: 160,
            emoji: "🩷",
            occasions: [.birthday, .anniversary, .valentines, .christmas],
            personalities: [.homebody, .wellness, .fashionista],
            interests: [.beauty],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Wine Tasting Experience",
            description: "A guided wine tasting at a local vineyard or wine bar — with cheese pairings and an expert sommelier.",
            whyItWorks: "Equal parts romantic and educational. A fantastic date you'll both talk about for months.",
            priceRange: "$60 – $120",
            minPrice: 60, maxPrice: 120,
            emoji: "🍷",
            occasions: [.anniversary, .valentines, .birthday, .justBecause],
            personalities: [.foodie, .social, .adventurous],
            interests: [.cooking, .travel],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Cashmere Sweater",
            description: "A cloud-soft cashmere sweater in her favourite colour. Elevates her wardrobe and wraps her in luxury every time she wears it.",
            whyItWorks: "Thoughtful, wearable, and genuinely luxurious. She'll think of you every chilly day.",
            priceRange: "$80 – $250",
            minPrice: 80, maxPrice: 250,
            emoji: "🧣",
            occasions: [.birthday, .christmas, .anniversary],
            personalities: [.fashionista, .homebody],
            interests: [.fashion],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Custom Star Map Print",
            description: "A beautifully framed map of the night sky exactly as it looked on a meaningful date — first date, anniversary, her birthday.",
            whyItWorks: "Romantic and sentimental. It says 'I remember exactly when everything changed with us.'",
            priceRange: "$30 – $80",
            minPrice: 30, maxPrice: 80,
            emoji: "🌟",
            occasions: [.anniversary, .valentines, .birthday],
            personalities: [.creative, .intellectual, .homebody],
            interests: [.art],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "AirPods Pro",
            description: "Apple's best wireless earbuds with noise cancellation — perfect for commutes, workouts, or simply her favourite playlist.",
            whyItWorks: "A practical luxury she'll use every single day. High perceived value and immediately useful.",
            priceRange: "$200 – $260",
            minPrice: 200, maxPrice: 260,
            emoji: "🎧",
            occasions: [.birthday, .christmas, .graduation],
            personalities: [.adventurous, .intellectual, .social],
            interests: [.music, .fitness, .tech],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Professional Photography Session",
            description: "Book a professional photographer for a solo portrait session, couples shoot, or family session. Gift her a memory.",
            whyItWorks: "Gives her beautiful photos she'd never invest in for herself. A keepsake that lasts a lifetime.",
            priceRange: "$100 – $350",
            minPrice: 100, maxPrice: 350,
            emoji: "📸",
            occasions: [.birthday, .anniversary, .graduation, .motherDay],
            personalities: [.creative, .fashionista, .social],
            interests: [.art, .travel],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Gourmet Chocolate Box",
            description: "An artisan selection of handcrafted chocolates from a premium chocolatier — truffles, ganaches, and pralines.",
            whyItWorks: "Never fails. Indulgent, shareable, and always welcome. Elevate it by picking her favourite flavours.",
            priceRange: "$25 – $75",
            minPrice: 25, maxPrice: 75,
            emoji: "🍫",
            occasions: [.birthday, .valentines, .anniversary, .christmas, .justBecause],
            personalities: [.foodie, .homebody, .social],
            interests: [.cooking],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Concert or Show Tickets",
            description: "Tickets to see her favourite artist, band, comedian, or theatre show. Surprise her with the event she's been waiting for.",
            whyItWorks: "An experience, not a thing. The anticipation and the night itself become a shared story you both tell.",
            priceRange: "$50 – $300",
            minPrice: 50, maxPrice: 300,
            emoji: "🎤",
            occasions: [.birthday, .anniversary, .justBecause],
            personalities: [.social, .adventurous, .creative],
            interests: [.music, .movies],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Leather-Bound Journal",
            description: "A high-quality leather journal with thick paper — ideal for journaling, sketching, or writing down thoughts and dreams.",
            whyItWorks: "Personal and lasting. Every page she fills will hold a piece of her inner life.",
            priceRange: "$20 – $60",
            minPrice: 20, maxPrice: 60,
            emoji: "📓",
            occasions: [.birthday, .christmas, .graduation, .justBecause],
            personalities: [.creative, .intellectual],
            interests: [.reading, .art],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Apple Watch",
            description: "The most capable smartwatch available — fitness tracking, notifications, health monitoring, and gorgeous design.",
            whyItWorks: "Combines style with function. If she's active or health-conscious, she'll love having it on her wrist every day.",
            priceRange: "$250 – $450",
            minPrice: 250, maxPrice: 450,
            emoji: "⌚",
            occasions: [.birthday, .christmas, .graduation],
            personalities: [.adventurous, .wellness],
            interests: [.fitness, .tech, .yoga],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Succulent Garden Kit",
            description: "A beautiful curated set of succulents with decorative pots, soil, and care instructions. Low maintenance, high charm.",
            whyItWorks: "Perfect for the homebody or plant lover. Brings life and colour to her space.",
            priceRange: "$20 – $55",
            minPrice: 20, maxPrice: 55,
            emoji: "🌵",
            occasions: [.birthday, .justBecause, .christmas],
            personalities: [.homebody, .creative, .wellness],
            interests: [.gardening],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Le Creuset Dutch Oven",
            description: "An iconic cast-iron Dutch oven in her favourite colour — built to last a lifetime and coveted by every serious home cook.",
            whyItWorks: "A dream purchase she'd rarely make for herself. Signals that you take her cooking passion seriously.",
            priceRange: "$100 – $350",
            minPrice: 100, maxPrice: 350,
            emoji: "🍲",
            occasions: [.birthday, .christmas, .anniversary],
            personalities: [.foodie, .homebody],
            interests: [.cooking],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Luxury Candle Set",
            description: "A curated collection of hand-poured soy candles in sophisticated scents — linen, white tea, amber, or fresh florals.",
            whyItWorks: "Candles make any space feel warm and intentional. She'll burn them and think of you.",
            priceRange: "$30 – $90",
            minPrice: 30, maxPrice: 90,
            emoji: "🕯️",
            occasions: [.birthday, .christmas, .valentines, .justBecause, .anniversary],
            personalities: [.homebody, .wellness, .creative],
            interests: [.yoga, .beauty],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Travel Accessories Set",
            description: "A premium set including a packing organiser, luggage tags, passport holder, and travel-sized toiletry bottles.",
            whyItWorks: "For the woman who loves to travel, this makes every trip easier. Practical and thoughtful.",
            priceRange: "$50 – $120",
            minPrice: 50, maxPrice: 120,
            emoji: "🧳",
            occasions: [.birthday, .christmas, .graduation],
            personalities: [.adventurous, .social],
            interests: [.travel],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Pottery Class",
            description: "A hands-on pottery session at a local studio — beginner-friendly and incredibly fun. She gets to keep what she makes.",
            whyItWorks: "Unique and memorable. She'll come home with something she made herself, and a great story to tell.",
            priceRange: "$50 – $100",
            minPrice: 50, maxPrice: 100,
            emoji: "🏺",
            occasions: [.birthday, .justBecause, .anniversary],
            personalities: [.creative, .adventurous],
            interests: [.art],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "MasterClass Subscription",
            description: "Unlimited access to world-class lessons from the best in every field — cooking, writing, music, film, and more.",
            whyItWorks: "A gift of knowledge and inspiration. Perfect for someone who's always curious and loves to learn.",
            priceRange: "$120 – $180",
            minPrice: 120, maxPrice: 180,
            emoji: "🎓",
            occasions: [.birthday, .christmas, .graduation],
            personalities: [.intellectual, .creative, .adventurous],
            interests: [.cooking, .reading, .music, .art],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Champagne & Strawberry Gift Basket",
            description: "A beautifully presented basket with champagne, dipped strawberries, cheese, crackers, and luxury treats.",
            whyItWorks: "Classic romance. Perfect for celebrating a milestone or simply making an ordinary evening feel extraordinary.",
            priceRange: "$60 – $150",
            minPrice: 60, maxPrice: 150,
            emoji: "🥂",
            occasions: [.anniversary, .valentines, .birthday, .justBecause],
            personalities: [.foodie, .social, .homebody],
            interests: [.cooking],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Monthly Flower Subscription",
            description: "Fresh seasonal flowers delivered to her door every month from a premium florist. Thoughtfulness that keeps giving.",
            whyItWorks: "A gift that lasts for months. Every delivery reminds her you were thinking about her happiness.",
            priceRange: "$40 – $80/month",
            minPrice: 40, maxPrice: 80,
            emoji: "💐",
            occasions: [.birthday, .valentines, .anniversary, .justBecause, .motherDay],
            personalities: [.homebody, .social, .fashionista],
            interests: [.gardening, .beauty],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Professional Makeup Palette",
            description: "A highly rated eyeshadow or face palette by a brand she loves — Charlotte Tilbury, Urban Decay, Pat McGrath.",
            whyItWorks: "High-end makeup is a luxury she may hesitate to buy herself. Getting the right brand shows you pay attention.",
            priceRange: "$40 – $100",
            minPrice: 40, maxPrice: 100,
            emoji: "💄",
            occasions: [.birthday, .christmas],
            personalities: [.fashionista, .creative],
            interests: [.beauty, .fashion],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Hiking Adventure Day",
            description: "Plan a scenic hike together followed by a picnic at the summit — pack her favourite snacks and a surprise playlist.",
            whyItWorks: "Free (or nearly free), adventurous, and deeply intentional. Shows you planned something for her, not just bought something.",
            priceRange: "$0 – $50",
            minPrice: 0, maxPrice: 50,
            emoji: "🥾",
            occasions: [.birthday, .justBecause, .anniversary],
            personalities: [.adventurous, .wellness],
            interests: [.fitness, .travel, .yoga],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Premium Coffee & Tea Set",
            description: "A curated gift box with single-origin coffees or loose-leaf teas, a beautiful mug, and a pour-over or infuser.",
            whyItWorks: "Elevates her daily ritual. Every morning she'll have a little moment that reminds her you notice the small things.",
            priceRange: "$30 – $80",
            minPrice: 30, maxPrice: 80,
            emoji: "☕",
            occasions: [.birthday, .christmas, .justBecause, .motherDay],
            personalities: [.homebody, .intellectual, .foodie],
            interests: [.cooking, .reading],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Dance Class for Two",
            description: "A salsa, tango, or ballroom dance lesson for couples. Fun, physical, and surprisingly romantic.",
            whyItWorks: "Creates a shared skill and a hilarious, memorable experience. The best gifts are the ones you do together.",
            priceRange: "$50 – $110",
            minPrice: 50, maxPrice: 110,
            emoji: "💃",
            occasions: [.anniversary, .valentines, .birthday, .justBecause],
            personalities: [.social, .adventurous, .creative],
            interests: [.fitness, .music],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Polaroid Camera",
            description: "A modern instant camera that prints physical photos immediately — capturing moments she can hold in her hands.",
            whyItWorks: "Tangible memories in a world of digital everything. She'll carry photos of you two everywhere.",
            priceRange: "$70 – $150",
            minPrice: 70, maxPrice: 150,
            emoji: "📷",
            occasions: [.birthday, .graduation, .christmas, .anniversary],
            personalities: [.creative, .adventurous, .social],
            interests: [.art, .travel, .movies],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Cozy Night In Basket",
            description: "A thoughtfully curated basket with a plush blanket, slippers, candle, face mask, hot cocoa, and her favourite snacks.",
            whyItWorks: "Shows you know exactly how she likes to unwind. Especially meaningful when she needs a night off from the world.",
            priceRange: "$50 – $100",
            minPrice: 50, maxPrice: 100,
            emoji: "🧸",
            occasions: [.valentines, .justBecause, .christmas, .birthday],
            personalities: [.homebody, .wellness],
            interests: [.movies, .yoga],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Book Club Subscription",
            description: "A monthly book subscription like Book of the Month or Literati — curated picks delivered to her door every month.",
            whyItWorks: "The gift that keeps arriving all year. Perfect for a reader who's always looking for her next favourite novel.",
            priceRange: "$15 – $45/month",
            minPrice: 15, maxPrice: 45,
            emoji: "📕",
            occasions: [.birthday, .christmas, .graduation],
            personalities: [.intellectual, .homebody],
            interests: [.reading],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Weighted Blanket",
            description: "A premium 15lb weighted blanket that mimics the feeling of a hug — deeply calming for anxious or stressed minds.",
            whyItWorks: "Luxurious, practical, and comforting. She'll use it every day and feel held, even when you're not there.",
            priceRange: "$60 – $120",
            minPrice: 60, maxPrice: 120,
            emoji: "🛏️",
            occasions: [.birthday, .christmas, .justBecause],
            personalities: [.homebody, .wellness],
            interests: [.yoga, .movies],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Personalised Recipe Book",
            description: "A custom printed recipe book filled with family recipes, her favourites, or the meals you've made together.",
            whyItWorks: "Deeply sentimental and useful. A gift she'll pass down and treasure for decades.",
            priceRange: "$30 – $70",
            minPrice: 30, maxPrice: 70,
            emoji: "📔",
            occasions: [.birthday, .anniversary, .motherDay, .christmas],
            personalities: [.foodie, .homebody, .creative],
            interests: [.cooking, .reading],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Smart Garden (Click & Grow)",
            description: "An indoor smart garden that grows herbs, flowers, or tomatoes year-round with minimal effort — no green thumb required.",
            whyItWorks: "Novel and delightful. Watching things grow is incredibly satisfying, and fresh herbs make every meal better.",
            priceRange: "$50 – $130",
            minPrice: 50, maxPrice: 130,
            emoji: "🌿",
            occasions: [.birthday, .christmas, .justBecause],
            personalities: [.homebody, .foodie, .intellectual],
            interests: [.gardening, .cooking],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Oversized Fashion Sunglasses",
            description: "A statement pair from Ray-Ban, Quay, or her preferred designer — classic aviators, cat-eyes, or oversized frames.",
            whyItWorks: "Wearable, stylish, and every fashionista appreciates a great pair of shades. Notice her current style first.",
            priceRange: "$30 – $200",
            minPrice: 30, maxPrice: 200,
            emoji: "🕶️",
            occasions: [.birthday, .justBecause, .graduation],
            personalities: [.fashionista, .adventurous, .social],
            interests: [.fashion, .travel],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Guided Meditation App Subscription",
            description: "A year of premium Calm or Headspace — sleep stories, breathing exercises, and daily meditations.",
            whyItWorks: "A genuinely caring gift. Tells her that her peace of mind matters to you.",
            priceRange: "$50 – $80",
            minPrice: 50, maxPrice: 80,
            emoji: "🌙",
            occasions: [.birthday, .christmas, .justBecause, .motherDay],
            personalities: [.wellness, .intellectual, .homebody],
            interests: [.yoga, .fitness],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Leather Handbag",
            description: "A quality leather tote, crossbody, or shoulder bag in her preferred colour — from a brand like Coach, Fossil, or Kate Spade.",
            whyItWorks: "A quality bag she carries every day is a constant reminder you invested in something real for her.",
            priceRange: "$150 – $500",
            minPrice: 150, maxPrice: 500,
            emoji: "👜",
            occasions: [.birthday, .anniversary, .christmas, .graduation],
            personalities: [.fashionista, .social],
            interests: [.fashion, .travel],
            stages: [.established, .longTerm]
        ),

        GiftRecommendation(
            name: "Barre or Pilates Class Pack",
            description: "A pack of 10 classes at a boutique barre or pilates studio — an experience that keeps her feeling strong and energised.",
            whyItWorks: "Invests in her health and something she loves doing. More personal than a generic gym membership.",
            priceRange: "$100 – $200",
            minPrice: 100, maxPrice: 200,
            emoji: "🩰",
            occasions: [.birthday, .christmas, .justBecause],
            personalities: [.wellness, .adventurous],
            interests: [.fitness, .yoga],
            stages: [.new, .established, .longTerm]
        ),

        GiftRecommendation(
            name: "Mini Projector for Movie Nights",
            description: "A portable HD projector you can set up in the living room, bedroom, or backyard for private cinema nights together.",
            whyItWorks: "A gift for both of you — future movie nights become an event. Sets up a ritual you'll repeat for years.",
            priceRange: "$80 – $200",
            minPrice: 80, maxPrice: 200,
            emoji: "🎥",
            occasions: [.anniversary, .birthday, .christmas, .valentines],
            personalities: [.homebody, .social, .creative],
            interests: [.movies],
            stages: [.established, .longTerm]
        ),

    ]
}
