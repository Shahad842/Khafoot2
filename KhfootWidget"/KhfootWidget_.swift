//
//  KhfootWidget_.swift
//  KhfootWidget"
//
//  Created by Renad fahad Alfurayhi on 17/05/1446 AH.
//


import WidgetKit
import SwiftUI
import AppIntents

struct QuoteWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "QuoteWidget", provider: Provider()) { entry in
            QuoteWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Daily Quotes")
        .description("Displays time and inspirational quotes")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: Date(), quote: quotes[0])
    }

    func getSnapshot(in context: Context, completion: @escaping (QuoteEntry) -> ()) {
        let entry = QuoteEntry(date: Date(), quote: quotes[0])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<QuoteEntry>) -> ()) {
        var entries: [QuoteEntry] = []
        let currentDate = Date()
        
        // Create 24 hours of timeline entries 30 minutes apart
        for minuteOffset in stride(from: 0, to: 24 * 60, by: 30) {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = QuoteEntry(date: entryDate, quote: quotes.randomElement()!)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    let quotes = [
        // Mindfulness Quotes
              Quote(text: "Breath is the bridge which connects life to consciousness.", author: "Thich Nhat Hanh"),
              Quote(text: "The present moment is filled with joy and happiness.", author: "Thich Nhat Hanh"),
              Quote(text: "Peace comes from within. Do not seek it without.", author: "Buddha"),
              Quote(text: "Every moment is a fresh beginning.", author: "T.S. Eliot"),
              
              // Relaxation Quotes
              Quote(text: "Take a deep breath. It's just a bad day, not a bad life.", author: "Anonymous"),
              Quote(text: "Your calm mind is the ultimate weapon against your challenges.", author: "Bryant McGill"),
              Quote(text: "Within you there is a stillness and sanctuary.", author: "Hermann Hesse"),
              Quote(text: "Calm mind brings inner strength and self-confidence.", author: "Dalai Lama"),
              
              // Self-Care Quotes
              Quote(text: "Self-care is not selfish. You cannot serve from an empty vessel.", author: "Eleanor Brown"),
              Quote(text: "Make peace with your past so it won't disturb your present.", author: "Anonymous"),
              Quote(text: "Take time to do what makes your soul happy.", author: "Anonymous"),
              Quote(text: "The time to relax is when you don't have time for it.", author: "Sydney J. Harris"),
              
              // Positive Thinking
              Quote(text: "Every day may not be good, but there's good in every day.", author: "Alice Morse Earle"),
              Quote(text: "Happiness is not by chance, but by choice.", author: "Jim Rohn"),
              Quote(text: "Choose to be optimistic, it feels better.", author: "Dalai Lama"),
              Quote(text: "A positive mind finds opportunity in everything.", author: "Anonymous"),
              
              // Meditation Quotes
              Quote(text: "The quieter you become, the more you can hear.", author: "Ram Dass"),
              Quote(text: "Silence is sometimes the best answer.", author: "Dalai Lama"),
              Quote(text: "Look within. Be still.", author: "Lao Tzu"),
              Quote(text: "Quiet the mind, and the soul will speak.", author: "Ma Jaya Sati Bhagavati"),
              
              // Nature-Inspired
              Quote(text: "Life is simple. Just breathe.", author: "Anonymous"),
              Quote(text: "In every walk with nature, one receives far more than he seeks.", author: "John Muir"),
              Quote(text: "Nature does not hurry, yet everything is accomplished.", author: "Lao Tzu"),
              Quote(text: "The earth has music for those who listen.", author: "George Santayana"),
              
              // Wisdom Quotes
              Quote(text: "The soul always knows what to do to heal itself.", author: "Lao Tzu"),
              Quote(text: "Let go of what you can't control.", author: "Anonymous"),
              Quote(text: "Be gentle with yourself.", author: "Anonymous"),
              Quote(text: "Trust the journey.", author: "Anonymous"),
              
              // Inspirational
              Quote(text: "You are enough just as you are.", author: "Anonymous"),
              Quote(text: "Where there is love there is life.", author: "Mahatma Gandhi"),
              Quote(text: "Everything you need is already within.", author: "Anonymous"),
              Quote(text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt")
          
    ]
}

struct Quote {
    let text: String
    let author: String
}

struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: Quote
}

struct QuoteWidgetEntryView : View {
    var entry: QuoteEntry
    @Environment(\.widgetFamily) var family
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: entry.date)
    }
    
    var body: some View {
        VStack(spacing: 10) {
            // Time
//            Text(timeString)
//                .font(.system(size: 28, weight: .bold))
//                .foregroundColor(.primary)
            
            // Quote
            Text(entry.quote.text)
                .font(.system(size: family == .systemSmall ? 13 : 15))
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .lineLimit(2)
            
            // Author
            Text("- " + entry.quote.author)
                .font(.system(size: family == .systemSmall ? 11 : 13))
                .foregroundColor(.secondary)
                .italic()
        }
        .padding()
    }
}

#Preview(as: .systemSmall) {
    QuoteWidget()
} timeline: {
    QuoteEntry(
        date: .now,
        quote: Quote(text: "Take a deep breath.", author: "Anonymous")
    )
}
