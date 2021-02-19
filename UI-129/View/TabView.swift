//
//  TabView.swift
//  UI-129
//
//  Created by にゃんにゃん丸 on 2021/02/19.
//

import SwiftUI

struct TabView: View {
    @State var selectedtab = "t1"
    @Namespace var animation
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @Environment(\.presentationMode) var preset

    var body: some View {
        VStack(spacing:0){
            
            GeometryReader{_ in
                
                ZStack{
                    NavigationLink(destination: Home(), label: {
                        ScrollView{
                            
                            ForEach(1...25,id:\.self){i in
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("ABC\(i)")
                                        .font(.title)
                                        .foregroundColor(.gray)
                                        .padding()
                                    Divider()
                                }
                            }
                            
                        }
                        .navigationBarHidden(true)
                    })
                    .opacity(selectedtab == "t1" ? 1 : 0)
                    
                    Text("2")
                        .opacity(selectedtab == "t2" ? 1 : 0)
                        
                    
                    Text("3")
                        .opacity(selectedtab == "t3" ? 1 : 0)
                        
                    
                    
                    
                    Text("4")
                        .opacity(selectedtab == "t4" ? 1 : 0)
                        
                    
                }
                .padding(.bottom)
               
                
            }
            
            HStack(spacing:0){
                
                ForEach(tabs,id:\.self){tab in
                    
                    TabButton(title: tab, selected: $selectedtab, animation: animation)
                    
                   
                    
                    if tab != tabs.last{Spacer(minLength: 0)}
                }
                
            }
            .padding(.horizontal)
            .padding(.bottom,edges?.bottom == 0 ? 15 :edges?.bottom)
            .background(Color.white)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        
    }
}

var tabs = ["t1","t2","t3","t4"]

struct TabButton : View {
    
    var title : String
    @Binding var selected : String
    var animation : Namespace.ID
    var body: some View{
        
            
            Button(action: {
                
                selected = title
            }) {
                
                VStack(spacing:6){
                    ZStack{
                        
                        CustomShape()
                            .fill(Color.clear)
                            .frame(width: 45, height: 6)
                        
                        if selected == title{
                            
                            CustomShape()
                                .fill(Color.red.opacity(selected == title ? 1 : 0))
                                .frame(width: 45, height: 6)
                                .matchedGeometryEffect(id: "Tab", in: animation)
                             
                        }
                        
                    }
                    
                    Image(title)
                        .renderingMode(.original)
                        .resizable()
                        .foregroundColor(selected == title ? .black : .gray)
                        .frame(width: 24, height: 24)
                    
                    Text(title)
                        .font(.title)
                        .foregroundColor(Color.black.opacity(selected == title ? 0.6 : 0.2))
                }
                
            }
            
        
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}

struct CustomeShape : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}
