//
//  CoachingMetaAppApp.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 3/7/23.
//

import Foundation
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct WorkoutWithTimer: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SignInView() {
                    //                    Task {
                    //                        do {
                    //                            try await conversationStore.save(conversations: store.conversations)
                    //                        } catch {
                    //                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    //                        }
                    //                    }
                }
            }
            //            .task {
            //                do {
            //                    store.conversations = try await conversationStore.load()
            //                } catch {
            //                    errorWrapper = ErrorWrapper(error: error, guidance: "Presentation Assistant will load sample data and continue.")
            //                }
            //            }
            //            .sheet(item: $errorWrapper, onDismiss: {
            //                store.conversations = Conversation.sampleData
            //            }) { wrapper in
            //                ErrorView(errorWrapper: wrapper)
            //            }
        }
    }
}
