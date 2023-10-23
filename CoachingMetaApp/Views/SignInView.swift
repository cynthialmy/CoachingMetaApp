//
//  SignInView.swift
//  CoachingMetaApp
//
//  Created by Cynthia LI on 3/9/23.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Combine

var userID: String = ""
var CoachID: String = ""

// color global vars..
var deepBlue = Color(hex: 0x003049)
var orange = Color(hex: 0xf77f00)
var yellow = Color(hex: 0xfcbf49)
var lightYellow = Color(hex: 0xeae2b7)

struct actIndSignin: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct SignInView: View {
    @State private var emailAddress = ""
    @State private var password = ""
    @State private var errorText = ""
    @State private var willMoveToNextScreen = false
    @State private var userRole: String = ""
    @State private var verifyEmail = true
    @State private var showEmailAlert = false
    @State private var showPasswordAlert = false
    @State private var shouldAnimate = false
    // TODO: add action to fetch matching info
    @State private var isMatched: Bool = false
    //    @State private var CoachID: String = ""
    
    private var systemService = SystemService()
    
    @Environment(\.presentationMode) var presentationMode
    
    // TODO: add features to login account
    var onDismiss: () -> ()
    
    
    init(onDismiss: @escaping () -> ()) {
        self.onDismiss = onDismiss
    }
    
    var alert: Alert {
        Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")){
            
            self.presentationMode.wrappedValue.dismiss()
            self.emailAddress = ""
            self.password = ""
            self.errorText = ""
            
        })
    }
    
    var verifyEmailAlert: Alert {
        Alert(title: Text("Verify your Email ID"), message: Text("Please click the link in the verification email sent to you"), dismissButton: .default(Text("Dismiss")){
            
            self.presentationMode.wrappedValue.dismiss()
            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errorText = ""
            
        })
    }
    
    var passwordResetAlert: Alert {
        Alert(title: Text("Reset your password"), message: Text("Please click the link in the password reset email sent to you"), dismissButton: .default(Text("Dismiss")){
            self.emailAddress = ""
            self.verifyEmail = true
            self.password = ""
            self.errorText = ""
        })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    ZStack{
                        GeometryReader { geo in // adjust picture size to fit the screen
                            HStack {
                                Image("mainPage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width*1.2)
                                    .offset(x: 20, y:-50)
                                Image("appstore")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width*1.2)
                                    .offset(x: 20, y:0)
                            }
                        }.edgesIgnoringSafeArea(.horizontal)
                        
                        ZStack{
                            Image("appstore").resizable().scaledToFit()
                                .offset(x: 0, y: 250)
                            VStack(spacing: 20){
                                Text("Coaching Meta").font(.system(size: 50)).bold().foregroundColor(Color.gray)
                                VStack(alignment: .leading, spacing: 15) {
                                    TextField("Email", text: self.$emailAddress).textContentType(.emailAddress)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(15.0)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                    
                                    SecureField("Password", text: self.$password)
                                        .padding()
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(15.0)
                                }
                                HStack (spacing: 30){
                                    Button(action: {
                                        self.shouldAnimate = true
                                        self.GreetUser(email:self.emailAddress, password:self.password)
                                    }) {
                                        Text("Sign In")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(width: 150, height: 50)
                                            .background(Color(hex: 0xf77f00))
                                            .cornerRadius(15.0)
                                        
                                    }
                                    Button(action: {
                                        print("Printing outputs" + self.emailAddress, self.password  )
                                        self.shouldAnimate = true
                                        self.CreateUser(email:self.emailAddress, password:self.password)
                                        
                                    }) {
                                        Text("Sign Up")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(width: 150, height: 50)
                                            .background(Color(hex: 0xfcbf49))
                                            .cornerRadius(15.0)
                                        
                                    }
                                    
                                }
                                Text(errorText).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading).foregroundColor(Color.gray)
                                actIndSignin(shouldAnimate: self.$shouldAnimate)
                                
                            }.offset(x: 0, y: 70).padding()
                            
                            
                        }
                    }
                }
                if (!verifyEmail) {
                    Button(action: {
                        Auth.auth().currentUser?.sendEmailVerification{error in
                            if let error = error {
                                self.errorText = error.localizedDescription
                                return
                            }
                            self.showPasswordAlert.toggle()
                        }
                    }) {
                        Text("Send Verify Email Again")
                    }
                }
                Spacer()
            }
            .navigationDestination(isPresented: $willMoveToNextScreen) {
                if (userRole == "client") {
                    if (isMatched){
                        BaseView()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                    } else {
                        MatchView()
                    }
                }
                else {
                    CoachBaseView()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }.accentColor(Color(hex: 0xf77f00)).ignoresSafeArea(.keyboard) // allow keyboard to disappear after tabiing other places
        //        .padding()
            .edgesIgnoringSafeArea(.top).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).background(Color.white)
            .alert(isPresented: $showEmailAlert, content: { self.verifyEmailAlert })
            .alert(isPresented: $showPasswordAlert, content: { self.passwordResetAlert })
    }
    
    private func GreetUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            
            if let error = error
            {
                self.errorText = error.localizedDescription
                self.shouldAnimate = false
                return
            }
            
            guard let user = user else { return }
            
            self.verifyEmail = user.user.isEmailVerified
            
            if(!self.verifyEmail)
            {
                self.errorText = "Please verify your email"
                self.shouldAnimate = false
                return
            }
            
            self.emailAddress = ""
            self.verifyEmail = true
            userID = Auth.auth().currentUser!.uid
            print("userID: " + userID)
            
            self.getUserRoleAndNavigate()
            print("user Role: " + self.userRole)
            self.getClientIsMatchAndNavigate()
            print("Matched: " + String(self.isMatched))
            self.password = ""
            self.errorText = ""
            self.onDismiss()
            self.presentationMode.wrappedValue.dismiss()
            self.shouldAnimate = false
            
        }
    }
    
    private func getUserRoleAndNavigate() {
        systemService.getUserRole { result in
            switch result {
            case .success(let userRoles): // Renamed to userRoles
                if let firstUserRole = userRoles.first { // Access the first element of the array
                    if firstUserRole.role == 0 {
                        self.userRole = "coach"
                    } else {
                        self.userRole = "client"
                    }
                    self.willMoveToNextScreen = true
                } else {
                    // Handle case when userRoles array is empty, if needed
                }
            case .failure(let error):
                self.errorText = error.localizedDescription
            }
        }
    }
    
    
    private func getClientIsMatchAndNavigate() {
        systemService.getUserIsMatch { result in
            switch result {
            case .success(let matchInfo):
                if matchInfo.coach_id == "" {
                    self.isMatched = false
                } else {
                    self.isMatched = true
                    CoachID = matchInfo.coach_id
                    print("match with \(CoachID)")
                }
            case .failure(let error):
                self.errorText = error.localizedDescription
            }
        }
    }
    
    private func createUserAndNavigate(uuid: String) {
        systemService.createUserToDB(uid: uuid, userRole: 1) { result in
            switch result {
            case .success(let response):
                if response.Info != "ER_DUP_ENTRY" {
                    self.userRole = "client"
                }
            case .failure(let error):
                self.errorText = error.localizedDescription
            }
            
        }
    }
    
    private func createMatchInfoAndNavigate(uuid: String) {
        systemService.createMatchInfo(client_id: uuid, coach_id:"") { result in
            switch result {
            case .success(let response):
                if response.Info != "ER_DUP_ENTRY" {
                    self.isMatched = false
                }
            case .failure(let error):
                self.errorText = error.localizedDescription
            }
        }
    }
    
    func CreateUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard let user = authResult?.user, error == nil else {
                let errorText: String  = error?.localizedDescription ?? "unknown error"
                self.errorText = errorText
                return
            }
            
            Auth.auth().currentUser?.sendEmailVerification { (error) in
                if let error = error {
                    self.errorText = error.localizedDescription
                    return
                }
                self.showEmailAlert.toggle() // This line was modified
                self.shouldAnimate = false
            }
            
            print("\(user.email!) created")
            userID = Auth.auth().currentUser!.uid
            self.createUserAndNavigate(uuid: userID)
            self.createMatchInfoAndNavigate(uuid: userID)
            self.willMoveToNextScreen = true
        }
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(onDismiss: {print("hi")})
    }
}
