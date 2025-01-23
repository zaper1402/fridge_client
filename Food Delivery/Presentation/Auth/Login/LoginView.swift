//
//  LoginView.swift
//  Food Delivery
//
//  Created by Loic HACHEME on 11/09/2023.
//

import SwiftUI
import NavigationBackport

struct LoginView: View {
    
    @State private var isChecked: Bool = false
    var service = AuthService.instance
    

    
    
    @EnvironmentObject var navigator: PathNavigator
    @StateObject private var vm = LoginViewModel()
    
    var body: some View {
        ScrollView {
            Image("logo")
                .resizable()
                .frame(width: 120,height: 120)
            
            Text("Sign in your account")
                .font(.custom("Satoshi-Bold", size: 18))
            contentFields
            Toggle("Remember me", isOn: $isChecked)
                .padding()
                .font(.headline)
            
          
            Group {
                signInBtn
                
                NBNavigationLink(value: Destination.forgotPassword) {
                    Text("Forgot password ?")
                        .font(.custom("Satoshi-Regular", size: 17))
                        .foregroundColor(Color.theme.accent)
                }
                
                
                
                Spacer().frame(height: 30)
               
                Spacer().frame(height: 20)
               
                Spacer().frame(height: 30)
                footerContent
                
            }
        }
        .navigationBarBackButtonHidden()
        .onError($vm.errorWrapper)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(NavRouteModel())
    }
}

extension LoginView {
    private var contentFields: some View {
        VStack(alignment: .leading) {
            
            Text("Email")
                .font(.custom("Satoshi-Bold", size: 17))
            
            emailFieldView
            
            if !vm.errorMsgForEmail.isEmpty {
                Text(vm.errorMsgForEmail)
                    .font(.custom("Satoshi-Regular", size: 15))
                    .foregroundColor(.theme.red)
            }
            Spacer().frame(height:20)
            
            Text("Password")
                .font(.custom("Satoshi-Bold", size: 17))
            
           
            
            passwordFieldVew
            if !vm.errorMsgForPassword.isEmpty {
                Text(vm.errorMsgForPassword)
                    .font(.custom("Satoshi-Regular", size: 15))
                    .foregroundColor(.theme.red)
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    private func login() {
        // Directly navigate to the home screen without hitting the API
        navigator.push(Destination.home)
    }

    private var emailFieldView: some View {
        TextField("Enter email", text: $vm.email)
            .padding()
            .background(Color.theme.fieldBackground)
            .cornerRadius(12)
            .overlay( RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke( !vm.errorMsgForEmail.isEmpty ? Color.theme.red :  Color(red: 0.09, green: 0.12, blue: 0.13).opacity(0.1),lineWidth: 1))
        
    }
    
    private var passwordFieldVew: some View {
        SecureField("Enter password", text: $vm.password)
            .padding()
            .background(Color.theme.fieldBackground)
            .cornerRadius(12)
            .overlay (
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(!vm.errorMsgForPassword.isEmpty ? Color.theme.red :  Color(red: 0.09, green: 0.12, blue: 0.13).opacity(0.1),lineWidth: 1)
            )
    }
    
    private var signInBtn: some View {
        Button {
            //hide keyboard
           
                UIApplication.shared.endEditing()
                login()
            
            
        } label: {
            if vm.isBusy {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.theme.accent)
                    .cornerRadius(12)
                    .padding()
                
            } else {
                Text("SIGN IN")
                    .foregroundColor(.white)
                    .font(.custom("Satoshi-Bold", size: 17))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.theme.accent)
                    .cornerRadius(12)
                    .padding()
                    
            }
            
            
        }.disabled(vm.isBusy)
       
    }
    
    
    
   
    
    private var footerContent: some View {
        HStack {
            Text("Don't have an account ?")
                .font(.custom("Satoshi-Regular", size: 16))
            
            Button {
                navigator.push(Destination.register)
            } label: {
                Text("Sign up")
                    .font(.custom("Satoshi-Regular", size: 17))
                    .foregroundColor(Color.theme.accent)
            }
            
            
            
            
            
        }
    }
}
