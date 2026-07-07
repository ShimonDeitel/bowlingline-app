import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var purchases: PurchaseManager
    @AppStorage("notify_bowlspend") private var notifyEnabled: Bool = true
    @AppStorage("showTotals_bowlspend") private var showTotals: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                Section("Preferences") {
                    Toggle("Show running totals", isOn: $showTotals)
                    Toggle("Reminders", isOn: $notifyEnabled)
                }
                Section("Bowlingline Pro") {
                    if purchases.isPurchased {
                        Label("Pro unlocked", systemImage: "checkmark.seal.fill")
                            .foregroundStyle(Theme.accent)
                    } else {
                        Button("Upgrade to Pro") {
                            Task { await purchases.purchase() }
                        }
                        .accessibilityIdentifier("upgradeButton")
                    }
                    Button("Restore Purchases") {
                        Task { await purchases.restore() }
                    }
                    .accessibilityIdentifier("restoreButton")
                }
                Section("About") {
                    Link("Privacy Policy", destination: URL(string: "https://shimondeitel.github.io/bowlingline-app/privacy.html")!)
                    Link("Terms of Use", destination: URL(string: "https://shimondeitel.github.io/bowlingline-app/terms.html")!)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .accessibilityIdentifier("settingsDoneButton")
                }
            }
        }
    }
}
