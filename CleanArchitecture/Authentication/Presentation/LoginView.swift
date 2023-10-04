import SwiftUI

struct LoginView: View {
  @ObservedObject var viewModel: LoginViewModel
  
  var body: some View {
    VStack(spacing: 16) {
      TextField("Username", text: $viewModel.username)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .accessibility(identifier: "Username")
      
      SecureField("Password", text: $viewModel.password)
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .accessibility(identifier: "Password")
      
      Button(action: {
        Task {
          await viewModel.login()
        }
      }) {
        Text("Login")
      }
      .padding()
      .background(viewModel.isLoggedIn ? Color.green : Color.blue)
      .cornerRadius(8)
      .foregroundColor(.white)
      .accessibility(identifier: "Login")
      
      if viewModel.isLoggedIn {
        Text("Logged In Successfully!")
          .foregroundColor(.green)
      }
      
      if let errorMessage = viewModel.errorMessage {
        Text(errorMessage)
          .foregroundColor(.red)
      }
    }
    .padding()
  }
}
