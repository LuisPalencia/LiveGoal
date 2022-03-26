//
//  TABS.swift
//  FootballApp
//
//  Created by CICE on 16/03/2022.
//

import SwiftUI

struct Tab: Equatable {
    var icon: Image?
    var title: String
}

struct Tabs<Label: View>: View {
  @Binding var tabs: [String] // The tab titles
  @Binding var selection: Int // Currently selected tab
  let underlineColor: Color // Color of the underline of the selected tab
  // Tab label rendering closure - provides the current title and if it's the currently selected tab
  let label: (String, Bool) -> Label

  var body: some View {
    // Pack the tabs horizontally and allow them to be scrolled
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 30) {
        ForEach(tabs, id: \.self) {
          self.tab(title: $0)
        }
      }.padding(.horizontal, 3) // Tuck the out-most elements in a bit
    }
  }

  private func tab(title: String) -> some View {
    let index = self.tabs.firstIndex(of: title)!
    let isSelected = index == selection
    return Button(action: {
      // Allows for animated transitions of the underline,
      // as well as other views on the same screen
      withAnimation {
         self.selection = index
      }
    }) {
      label(title, isSelected)
        .overlay(Rectangle() // The line under the tab
          .frame(height: 2)
           // The underline is visible only for the currently selected tab
          .foregroundColor(isSelected ? underlineColor : .clear)
          .padding(.top, 2)
          // Animates the tab selection
          .transition(.move(edge: .bottom)) ,alignment: .bottomLeading)
    }
  }
}

    
    
struct Tabsold2: View {
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))

                                        // Text
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color.white)
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    }
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                    // Bar Indicator
                                    Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                        .frame(height: 3)
                                }.fixedSize()
                            })
                                .accentColor(Color.white)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .onAppear(perform: {
            UIScrollView.appearance().backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
            //UIScrollView.appearance().bounces = fixed ? false : true
            UIScrollView.appearance().bounces = true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

struct TabsOLD: View {
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)
                                            .foregroundColor(.white)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))

                                        // Text
                                        Text(tabs[row].title)
                                            .font(Font.system(size: 18, weight: .semibold))
                                            .foregroundColor(Color.white)
                                            .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                    }
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                    // Bar Indicator
                                    Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                        .frame(height: 3)
                                }.fixedSize()
                            })
                                .accentColor(Color.white)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .onAppear(perform: {
            UIScrollView.appearance().backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}


/*
struct Tabs: View {
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(0 ..< tabs.count, id: \.self) { row in
                        Button(action: {
                            withAnimation {
                                selectedTab = row
                            }
                        }, label: {
                            VStack(spacing: 0) {
                                HStack {
                                    // Image
                                    AnyView(tabs[row].icon)
                                        .foregroundColor(.white)
                                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))

                                    // Text
                                    Text(tabs[row].title)
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color.white)
                                        .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                }
                                .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                // Bar Indicator
                                Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                    .frame(height: 3)
                            }.fixedSize()
                        })
                            .accentColor(Color.white)
                            .buttonStyle(PlainButtonStyle())
                    }
                }
                
                //.padding([.leading, .trailing], 10)
            }
        }
        
        .background(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
        .frame(height: 55)
                .onAppear(perform: {
                    //UIScrollView.appearance().backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
                    //UIScrollView.appearance().bounces = fixed ? false : true
                })
                .onDisappear(perform: {
                    //UIScrollView.appearance().bounces = true
                })
    }
}
*/
/*
struct TabsV2: View {
    var fixed = true
    var tabs: [Tab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                ForEach(0 ..< tabs.count, id: \.self) { row in
                                    Button(action: {
                                        withAnimation {
                                            selectedTab = row
                                        }
                                    }, label: {
                                        VStack(spacing: 0) {
                                            HStack {
                                                // Image
                                                AnyView(tabs[row].icon)
                                                    .foregroundColor(.white)
                                                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))

                                                // Text
                                                Text(tabs[row].title)
                                                    .font(Font.system(size: 18, weight: .semibold))
                                                    .foregroundColor(Color.white)
                                                    .padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 15))
                                            }
                                            .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                            // Bar Indicator
                                            Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                                .frame(height: 3)
                                        }.fixedSize()
                                    })
                                        .accentColor(Color.white)
                                        .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .onChange(of: selectedTab) { target in
                                withAnimation {
                                    proxy.scrollTo(target)
                                }
                            }
                        }
                    }
                }
                .frame(height: 55)
                .onAppear(perform: {
                    UIScrollView.appearance().backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
                    UIScrollView.appearance().bounces = fixed ? false : true
                })
                .onDisappear(perform: {
                    UIScrollView.appearance().bounces = true
                })
    }
}
 */

//struct Tabs_Previews: PreviewProvider {
//    static var previews: some View {
//        Tabs(fixed: true, tabs: [Tab(icon: Image("star.fill"), title: "Tab 1"), Tab(icon: Image("star.fill"), title: "Tab 2"), Tab(icon: Image("star.fill"), title: "Tab 3")], geoWidth: 375, selectedTab: .constant(0))
//    }
//}
