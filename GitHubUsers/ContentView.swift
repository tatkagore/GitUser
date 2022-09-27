//
//  ContentView.swift
//  GitHubUsers
//
//  Created by Tatiana Simmer on 27/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var user = User(login: "", id: 0, repositories: 0, avatarUrl: "")
    
    @State private var searchForUser = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Button {
                    Task {
                        user = try await getRandomUser(username: searchForUser)
                    }
                } label: {
                    Text("Search user")
                }
                .buttonStyle(GrowingButton())
                .searchable(text: $searchForUser, placement: .navigationBarDrawer(displayMode: .always))
                Spacer()
                Text(user.login)
                    .bold()
                Text("\(user.repositories) public repos")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                
                AsyncImage(url: URL(string: user.avatarUrl)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 300, height: 300)
                    case .failure:
                        Image(systemName: "multiply")
                    @unknown default:
                        Image(systemName: "plus")
                    }
                }
                    //.padding()
                    Spacer()
                }
                .navigationTitle("GitHub User")
            }
        }
    }
    
    struct GrowingButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(.purple)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
