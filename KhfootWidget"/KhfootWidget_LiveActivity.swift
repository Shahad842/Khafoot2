//
//  KhfootWidget_LiveActivity.swift
//  KhfootWidget"
//
//  Created by Renad fahad Alfurayhi on 17/05/1446 AH.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct KhfootWidget_Attributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct KhfootWidget_LiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: KhfootWidget_Attributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension KhfootWidget_Attributes {
    fileprivate static var preview: KhfootWidget_Attributes {
        KhfootWidget_Attributes(name: "World")
    }
}

extension KhfootWidget_Attributes.ContentState {
    fileprivate static var smiley: KhfootWidget_Attributes.ContentState {
        KhfootWidget_Attributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: KhfootWidget_Attributes.ContentState {
         KhfootWidget_Attributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: KhfootWidget_Attributes.preview) {
   KhfootWidget_LiveActivity()
} contentStates: {
    KhfootWidget_Attributes.ContentState.smiley
    KhfootWidget_Attributes.ContentState.starEyes
}
