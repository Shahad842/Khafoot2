import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var soundEnabled = false
    
    var body: some View {
        Form {
            // Notifications Section
            Section(header: Text("Notifications")
                        .font(.headline)
                        .padding(.top)) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    .accessibilityLabel("تفعيل الإشعارات")
                    .accessibilityHint("عند التفعيل، ستتلقى الإشعارات وكل شيء جديد.")
                
                Text("Upon activation, you will receive notifications and everything new.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
                    .accessibilityLabel("وصف الإشعارات")
                    .accessibilityHint("سوف تتلقى إشعارات عند تفعيل الخيار")
            }
            
            // Sound Section
            Section(header: Text("Sound")
                        .font(.headline)) {
                Toggle("Enable Sound", isOn: $soundEnabled)
                    .accessibilityLabel("تفعيل الصوت")
                    .accessibilityHint("عند التفعيل، سيتم تفعيل الأصوات حولك.")
                
                Text("When you allow, the sounds around you will be accessible.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
                    .accessibilityLabel("وصف الصوت")
                    .accessibilityHint("عند التفعيل، سيتم تفعيل الأصوات حولك لتكون قابلة للوصول.")
            }
            
            // Problem Report Section
            Section(header: Text("Problem")
                        .font(.headline)) {
                Button(action: reportProblem) {
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .foregroundColor(.green)
                        Text("Report Problem")
                    }
                }
                .accessibilityLabel("الإبلاغ عن مشكلة")
                .accessibilityHint("اضغط للإبلاغ عن مشكلة عبر البريد الإلكتروني.")
                
                Text("If there is a problem, you can contact us via email to solve it.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 4)
                    .accessibilityLabel("وصف الإبلاغ عن المشكلة")
                    .accessibilityHint("إذا كانت هناك مشكلة، يمكنك التواصل معنا لحلها.")
            }
        }
        .navigationTitle("Settings")
        .navigationBarBackButtonHidden(true) // إخفاء زر الرجوع
    }
    
    private func reportProblem() {
        let email = "khafoot.info@gmail.com"
        let subject = "Report a Problem"
        let body = "Please describe your issue."
        
        // Encoding the subject and body
        guard let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Failed to encode subject or body")
            return
        }
        
        // Creating the mailto URL
        let urlString = "mailto:\(email)?subject=\(subjectEncoded)&body=\(bodyEncoded)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        // Checking if the URL can be opened
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:]) { success in
                if !success {
                    print("Failed to open email app.")
                }
            }
        } else {
            print("Cannot open URL: \(urlString)")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
