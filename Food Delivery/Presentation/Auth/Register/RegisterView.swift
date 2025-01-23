//
//  RegisterView.swift
//  Food Delivery
//
//  Created by Loic HACHEME on 11/09/2023.
//

import SwiftUI
import NavigationBackport

struct RegisterView: View {
    @State private var emailField: String = ""
    @State private var passwordField: String = ""
    @State private var confirmPasswordField: String = ""
    @State private var name: String = ""
    @State private var DOB:Date = Date()
    @State private var isDOBPickerVisible: Bool = false

    @EnvironmentObject private var navigator: PathNavigator
    
    
    var body: some View {
        
            ScrollView {
//                Image("food_logo")
//                    .resizable()
//                    .frame(width: 120, height: 120)
                
                Text("Sign up your account")
                    .font(.custom("Satoshi-Bold", size: 18))
                
                
                
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.custom("Satoshi-Bold", size: 18))
                        
                    
                    TextField("Enter Name", text: $name)
                        .padding()
                        .background(Color.theme.fieldBackground)
                        .cornerRadius(12)
                        .overlay (
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.09, green: 0.12, blue: 0.13).opacity(0.1), lineWidth: 1)

                        )
                    
                    Text("Date of Birth")
                                       .font(.custom("Satoshi-Bold", size: 18))
                                   Button(action: {
                                       withAnimation {
                                           isDOBPickerVisible.toggle()
                                       }
                                   }) {
                                       HStack {
                                           Text(DOB, style: .date) // Display the selected date
                                               .foregroundColor(DOB == Date() ? .gray : .black)
                                           Spacer()
                                           Image(systemName: "calendar")
                                               .foregroundColor(.gray)
                                       }
                                       .padding()
                                       .background(Color.theme.fieldBackground)
                                       .cornerRadius(12)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 12)
                                               .stroke(Color(red: 0.09, green: 0.12, blue: 0.13).opacity(0.1), lineWidth: 1)
                                       )
                                   }
                                   
                                   if isDOBPickerVisible {
                                       DatePicker("Select Date", selection: $DOB, displayedComponents: .date)
                                           .datePickerStyle(.graphical)
                                           .padding()
                                           .background(Color.white)
                                           .cornerRadius(12)
                                           .shadow(radius: 5)
                                   }
                                   
                    Spacer().frame(height: 20);                    Text("Email")
                        .font(.custom("Satoshi-Bold", size: 18))
                        
                    
                    TextField("Enter email", text: $emailField)
                        .padding()
                        .background(Color.theme.fieldBackground)
                        .cornerRadius(12)
                        .overlay (
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.09, green: 0.12, blue: 0.13).opacity(0.1), lineWidth: 1)

                        )
                    
                    Spacer().frame(height: 20)
                    
                    
                    Text("Password")
                        .font(.custom("Satoshi-Bold", size: 18))
                       
                    
                    SecureField("Enter password", text: $passwordField)
                        .padding()
                        .background(Color.theme.fieldBackground)
                        .cornerRadius(12)
                        .overlay (
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.09, green: 0.12, blue: 0.13).opacity(0.1), lineWidth: 1)

                        )
                    
                    
                    Spacer().frame(height: 20)
                    
                    
                    Text("Repeat password")
                        .font(.custom("Satoshi-Bold", size: 18))
                        
                    
                    SecureField("Confirm", text: $confirmPasswordField)
                        .padding()
                        .background(Color.theme.fieldBackground)
                        .cornerRadius(12)
                        .overlay (
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.09, green: 0.12, blue: 0.13).opacity(0.1), lineWidth: 1)

                        )
                    
                    
                    
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                
                Button {
                    navigator.push(Destination.bio)
                } label: {
                    Text("NEXT")
                        .font(.custom("Satoshi-Bold", size: 18))
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.theme.accent)
                        .cornerRadius(50)
                        .padding()
                    
                }
                
                Spacer().frame(height: 20)
                
             
                
                Spacer().frame(height: 20)
                
                HStack {
                    Text("Already have an account ?")
                    Button("Sign in") {
                        navigator.pop()
                    }
                }
                
               
            }
        
       
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
