//
//  ContentView.swift
//  Aura
//
//  Created by Stevhen on 30/09/20.
//

import SwiftUI
import PartialSheet

struct OnboardingView: View {
    @State private var selectedPage: Int = 0
    @State var showingHealthKitConnectPage: Bool = false
    @State var showingAppleConnectPromptPage: Bool = false
    
    @State var showingChangeLanguageModal: Bool = false
    
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @ObservedObject var card = OnboardingCardViewModel()
    
    @EnvironmentObject var healthManagerViewModel: HealthManagerViewModel
    
    func fetchCards() {
        self.card.fetchCards(UserDefaults.standard.string(forKey: "appLanguage")!)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
                ZStack {
                    HStack {
                        Button(action: {
                            
                            print("Change Language button clicked")
                            self.showingChangeLanguageModal.toggle()
                            
                        }, label: {
                            
                            Image(OnboardingLanguage.getData(language: UserDefaults.standard.string(forKey: "appLanguage")!)[0])
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 34, height: 34)
                            
                        })
                        .partialSheet(isPresented: $showingChangeLanguageModal)
                        {
                            ChangeLanguageModalView(showingChangeLanguageModal: $showingChangeLanguageModal, card: card)
                        }
                        
                        Spacer()
                        
                    }
                    .padding()
                    .font(.custom("Graphik-Regular", size: 17))
                }
                
                HStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 25, alignment: .center)
                }
                
                TabView(selection: $selectedPage) {
                    
                    ForEach (0 ..< card.cards.count, id: \.self) { i in
                        OnboardingCardView(card: card.cards[i])
                            .tag(i)
                    }
                    //CardView(card: Card(image: "onboarding1", title: "Request Alert", desc: "Alert your surroundings and send immediate help requests to emergency contact."))
                    
                }
                .onAppear {
                    fetchCards()
                    UITabBar.appearance().backgroundColor = UIColor.white
                    UITabBar.appearance().barTintColor = .white
                }
                .accentColor(.blue)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                VStack {
                    
                    // MARK: - Navigations
                    ZStack {
//                        NavigationLink(
//                            destination: (),
//                            isActive: $showingHealthKitConnectPage,
//                            label: {
//                                Text("")
//                            })
                        
                        NavigationLink(
                            destination: UserAuthView(),
                            isActive: $showingAppleConnectPromptPage,
                            label: {
                                Text("")
                            })
                    }
                    .hidden()
                    
                    HStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 50, alignment: .center)
                    }
                    
                    //MARK: - Page Indicator - Button HStack
                    VStack {
                        HStack {
                            PageIndicator(numPages: card.cards.count, currentPage: $selectedPage)
                                .offset(y: -20)
                        }
                        
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
                                selectedPage = (selectedPage + 1)
                                print(selectedPage)
                                //next view if last page
                                if selectedPage == card.cards.count {
                                    //wrap inside navigation view (move home page navView)
                                    UserDefaults.standard.set(true, forKey: "isOnboarded")
                                    
                                    healthManagerViewModel.request()
                                    
                                    self.showingAppleConnectPromptPage.toggle()
                                }
                                print("next clicked")
                                //selectedPage = (selectedPage + 1) % card.cards.count
                                
                            }, label: {
                                VStack(spacing: 20) {
                                    
                                    Text(selectedPage != 2 ? OnboardingLanguage.getData(language: UserDefaults.standard.string(forKey: "appLanguage")!)[1] : OnboardingLanguage.getData(language: UserDefaults.standard.string(forKey: "appLanguage")!)[2])
                                        .foregroundColor(.white)
                                        .bold()
                                        .frame(width: selectedPage != 2 ? 105 : 171, height: 25)
                                        .padding(.vertical)
                                        .background(AuraColors.solidPurple)
                                        .cornerRadius(8)
                                    
                                    ZStack {
                                        Button(action: {
                                            //Skip Set HealthKitConnect Page
                                            //Go to ConnectToApple
                                            print("Skip for now clicked")
                                            self.showingAppleConnectPromptPage.toggle()
                                            
                                        }, label: {
                                            Text(OnboardingLanguage.getData(language: UserDefaults.standard.string(forKey: "appLanguage")!)[3])
                                                .foregroundColor(.gray)
                                                .font(.custom("Graphik-Regular", size: 13))
                                        })
                                    }
                                    .opacity(selectedPage == card.cards.count-1 ? 1 : 0)
                                }
                            })
                            
                            Spacer()
                        }
                        .padding(.vertical, 25)
                        .padding(.horizontal, 67)
                    }
                }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct DotIndicator: View {
    let minScale: CGFloat = 1
    let maxScale: CGFloat = 1.1
    let minOpacity: Double = 0.6
    
    let pageIndex: Int
    @Binding var selectedPage: Int
    
    var body: some View {
        
        Button(action: {
            self.selectedPage = self.pageIndex
        }) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(selectedPage == pageIndex ? AuraColors.solidPurple : .gray)
                .frame(width: 6, height: 6)
            //            .frame(width: selectedPage == pageIndex ? 19 : 6, height: 6)
            
        }
        
    }
}

// MARK: - Page Indicator
struct PageIndicator: View {
    private let spacing: CGFloat = 9
    private let diameter: CGFloat = 7
    
    let numPages: Int
    @Binding var selectedIndex: Int
    
    init(numPages: Int, currentPage: Binding<Int>) {
        self.numPages = numPages
        self._selectedIndex = currentPage
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: spacing) {
                ForEach(0 ..< numPages, id: \.self) { i in
                    DotIndicator(
                        pageIndex: i,
                        selectedPage: self.$selectedIndex
                    )
                    
                }
            }
        }
    }
}

struct SplashView: View {
    
    @State var isActive: Bool = false
    @State var isOnboarded: Bool = UserDefaults.standard.bool(forKey: "isOnboarded")
    
    var body: some View {
        VStack {
            if self.isActive {
                
                if !isOnboarded {
                    OnboardingView()
                } else {
                    HomePageView().navigationBarHidden(true)
                }
                
            } else {
                
                Image("aura-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
            }
        }
        
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                withAnimation {
                    self.isActive = true
                }
            }
        }
        
        .addPartialSheet(style: PartialSheetStyle(background: .solid(Color.white), handlerBarColor: .white, enableCover: true, coverColor: Color.black.opacity(0.6), cornerRadius: 8.0, minTopDistance: 10))
    }
    
}

struct HealthKitConnectPage: View {
    var body: some View {
        Text("HealthKitPage")
            .padding()
            
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

struct AppleConnectPromptPage: View {
    var body: some View {
        Text("AppleConnectPromptPage")
            .padding()
            
            .navigationTitle("")
            .navigationBarHidden(true)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
