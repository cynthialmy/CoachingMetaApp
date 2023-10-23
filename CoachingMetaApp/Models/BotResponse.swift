//
//  BotResponse.swift
//  CoachingMetaApp
//
//  Created by Sicilia Li on 3/7/23.
//

import Foundation

//TODO: add more response for chatbot ? 
func getBotResponse(message: String) -> String {
    let tempMessage = message.lowercased()
    if tempMessage.contains("explain") && tempMessage.contains("hiit") {
        return "HIIT is a workout that alternates short periods of intense exercise with rest periods. It helps improve fitness and health benefits by challenging the body to work at a high intensity for a short period of time."
    }
    if tempMessage.contains("explain") && tempMessage.contains("core training") {
        return "Core training involves exercises that target the muscles of the abdomen, lower back, and pelvis to improve stability, balance, and posture."
    }
    if tempMessage.contains("explain") && tempMessage.contains("Yoga") {
        return "Yoga is a mind-body practice that includes physical postures, breathing exercises, and meditation. Its goal is to promote relaxation, reduce stress, and improve physical and mental health."
    }
    else {
        return "I don't quite understand your question. "
    }
//    if tempMessage.contains("keep fit") {
//        return "Question 2: How many days can you spend on exercising?"
//    }
//    if tempMessage.contains("day") {
//        return "Question 3: Which part of your body you want to exercise?"
//    }
//    if tempMessage.contains("legs") {
//        return "Ok, Purpose understood."
//    }
//    if tempMessage.contains("plan") {
//        return "OK. Let us create a plan for you."
//    }
//    else {
//        return "I don't quite understand your question."
//    }
}
