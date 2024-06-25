//
//  LoginView.swift
//  ArtMuseum
//
//  Created by 정유진 on 6/22/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoginError: Bool = false
    
    func login() {
        if email == "" || password == "" {
            isLoginError = true
        } else {
            print("Email: \(email), Password: \(password)")
        }
    }
}

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    @ViewBuilder
    func titleView(width: CGFloat) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Your\nArt\nMuseum")
                    .textCase(.uppercase)
                    .font(.system(size: 36, weight: .bold))
                    .padding(.bottom)
                Spacer()
            }
            HStack {
                Text("151 3rd St\nSan Francisco, CA 94103")
                    .font(.system(size: 12))
                Spacer()
            }
        }
        .frame(width: width/1.5)
    }
    
    @ViewBuilder
    func loginForm(width: CGFloat) -> some View {
        VStack(spacing: 1) {
            TextField("Email address", text: $viewModel.email)
                .padding()
                .background(Color.white)
                .foregroundStyle(Color.black)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.white)
                .foregroundStyle(Color.black)
            
            HStack {
                Spacer()
                Button(action : {}) {
                    Text("Forgot your passsword?")
                        .font(.system(size: 10))
                }
            }
            .padding(.top, 5)
        }
        .frame(width: width/1.5)
        .padding(.top)
       
    }
    
    @State var isLoginError: Bool = false
    @ViewBuilder
    func loginButton(width: CGFloat) -> some View {
        VStack(spacing: 10) {
            
            Button(action: {
                viewModel.login()
            }) {
                Text("Log In")
                    .font(.system(size: 12, weight: .semibold))
                    .frame(width: width/1.5)
                    .frame(height: 42)
                    .background(Color(hex: "#FF473A"))
                    .foregroundColor(.white)
            }
            .padding(.top)
            
            Button(action: {}) {
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 10))
                    Spacer()
                }
            }
        }
        .frame(width: width/1.5)
        .alert(isPresented: $viewModel.isLoginError) {
            Alert(title: Text("Error"),
                  message: Text("Invalid email or password"),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    @ViewBuilder
    func backgroundImage(fileName: String) -> some View {
        Image(fileName)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            
            VStack {
                titleView(width: width)
                
                loginForm(width: width)
                
                loginButton(width: width)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                backgroundImage(fileName: "login_background")
            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
