import SwiftUI

@main
struct CleanArchitectureApp: App {
  let userRepository: UserRepositoryProtocol
  let authenticationService: AuthenticationService
  let loginUseCase: LoginUseCaseProtocol
  
  init() {
    self.userRepository = InMemoryUserRepository()
    self.authenticationService = DefaultAuthenticationService(userRepository: userRepository)
    self.loginUseCase = DefaultLoginUseCase(authenticationService: authenticationService)
  }
  
  var body: some Scene {
    WindowGroup {
      LoginView(viewModel: LoginViewModel(loginUseCase: loginUseCase))
    }
  }
}
