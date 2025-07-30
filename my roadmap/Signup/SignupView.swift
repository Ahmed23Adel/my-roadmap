//
//  SignupView.swift
//  my roadmap
//
//  Created by ahmed on 21/07/2025.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = SignUpViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ZStack{ //START: ZStack
            if viewModel.isShowLoading{ // START: if loading
                FixedProgressView()
            } else{ // START: else if loading
                NavigationView{ // START: NavigationView
                    VStack{ // START: VStack
                        Group{ // START: Group
                            Text("Sign up ")
                                .font(.title)
                                .padding(.vertical, 7)
                                .foregroundColor(Color(red: 186/255, green: 142/255, blue: 35/255))
                                .bold()
                            
                            Text("Plan your roadmap")
                                .font(.title2)
                                .foregroundColor(Color(red: 186/255, green: 142/255, blue: 35/255))
                            
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 180)
                        } // END: Group
                        
                        Form{ //START: form
                            InputFieldWithErrorView(field: viewModel.firstName) {
                                TextField("First name", text: $viewModel.firstName.value)
                                    .padding()
                            }
                            
                            InputFieldWithErrorView(field: viewModel.firstName) {
                                TextField("Last name", text: $viewModel.lastName.value)
                                    .padding()
                            }
                            
                            InputFieldWithErrorView(field: viewModel.firstName) {
                                TextField("Email", text: $viewModel.email.value)
                                    .padding()
                            }
                            
                            InputFieldWithErrorView(field: viewModel.firstName) {
                                PasswordView(password: $viewModel.password.value)
                                    .padding()
                            }
                            
                            
                            
                            
                            
                            HStack{ //START: HStack for submit
                                Spacer()
                                Button("Submit"){
                                    viewModel.tryToSubmit()
                                }
                                .buttonStyle(.borderedProminent)
                                .disabled(!viewModel.isFormValid())
                                .frame(width: 150, height: 60)
                                .controlSize(.large)
                                .tint(Color.yellow)
                                Spacer()
                            } //END: HStack for submit
                            
                            
                        } //END: form
                        .scrollContentBackground(.hidden)
                        Button("Login"){
                            viewModel.navigateToLoginScreen()
                        }
                    } // END: VStack
                    
                    
                } // END: NavigationView
            } // END: else if loading
            
        }// END: ZStack
        .onAppear{
            viewModel.setCoordinator(coordinator: coordinator)
        }
        .alert(isPresented: $viewModel.isShowAlert){
            Alert(title: Text("Notice"),
                  message: Text(viewModel.alertMsg),
                  dismissButton: .default(Text("OK"))
                  )
        }
    }
}

#Preview {
    SignupView()
}
