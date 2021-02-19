//
//  Home.swift
//  UI-129
//
//  Created by にゃんにゃん丸 on 2021/02/19.
//

import SwiftUI

struct Home: View {
    @State var meesage = ""
    @StateObject var msgModel = Messages()
    
    @State var imagepicker = false
    @State var imagedata : Data = Data(count: 0)
    var body: some View {
        VStack{
            
            HStack{
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .font(.system(size: 20))
                })
                
                Spacer()
                
                
                NavigationLink(destination: TabView()) {
                    
                    Image(systemName: "gear")
                        .font(.title)
                        .font(.system(size: 20))
                    
                    
                }
              
                  
                 
                
            }
            .foregroundColor(.white)
            
            .overlay(
            
                VStack{
                    
                    Text("Catherine")
                        .font(.title)
                    
                    
                    Text("Actction")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    
                        
                    
                    
                    
                    
                }
            )
            .padding(.all)
            
            VStack{
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    ScrollViewReader{reader in
                        
                        VStack(spacing:20){
                            
                            ForEach(msgModel.messages){msg in
                                
                                
                                ChatBubble(msg: msg)
                                
                                
                            }
                            .onAppear(perform: {
                                
                                
                                let lastid = msgModel.messages.last!.id
                                reader.scrollTo(lastid,anchor:.bottom)
                                
                            })

                        }
                        .padding([.horizontal,.bottom])
                        .padding(.top,25)
                        
                        
                    }
                    
                })
                
                HStack(spacing:15){
                    
                    HStack(spacing:15){
                        
                        TextField("Enter", text: $meesage)
                        
                        
                        Button(action: {
                            imagepicker.toggle()
                            
                        }, label: {
                            Image(systemName: "paperclip.circle.fill")
                                .font(.title)
                                
                        })
                        
                    }
                    .padding(.vertical,12)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.06))
                    .clipShape(Capsule())
                        
                        if meesage != ""{
                            
                            Button(action: {
                                
                                withAnimation(.easeIn){
                                    
                                    msgModel.messages.append(Message(id: Date(), massage: meesage, Mymsg: true, profilepic: "p2", phto: nil))
                                    
                                }
                                
                                
                                meesage = ""
                            }, label: {
                                Image(systemName: "paperplane.fill")
                                    .font(.system(size: 23))
                                    .rotationEffect(.init(degrees: 45))
                                    .foregroundColor(.gray)
                                    .padding(.vertical,12)
                                    .padding(.leading,12)
                                    .padding(.trailing,17)
                                    .background(Color.black.opacity(0.03))
                                    .clipShape(Capsule())
                                
                                
                                    
                            })
                            
                            
                            
                        }
                        
                        
                   
                    
                }
                .padding(.horizontal)
                .animation(.easeOut)
                
            }
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color.white.clipShape(CustomShape()))
            
            
          
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.purple.opacity(0.3).edgesIgnoringSafeArea(.top))
        .fullScreenCover(isPresented: $imagepicker, onDismiss: {
            
            if imagedata.count != 0{
                
                
                msgModel.writemessage(id: Date(), message: "", Mymsg: true, profilpixc: "p1", photo: self.imagedata)
            }
            
        }) {
            
            Imagepicker(imagepicker: $imagepicker, imagedata: $imagedata)
            
        }
        .navigationBarHidden(true)
        .navigationTitle("")
       
        
       
      
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct Imagepicker : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        
        return Imagepicker.Coordinator(parent: self)
    }
    
    
    @Binding var imagepicker : Bool
    @Binding var imagedata : Data
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        let view = UIImagePickerController()
        view.sourceType = .photoLibrary
        view.delegate = context.coordinator
        return view
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var parent : Imagepicker
        init(parent : Imagepicker) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            parent.imagepicker.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            
            parent.imagedata = image.jpegData(compressionQuality: 0.5)!
            
            parent.imagepicker.toggle()
        }
        
     
        
    }
}

struct ChatBubble : View {
    var msg : Message
    
    var body: some View{
        
        HStack(spacing:10){
            
            if msg.Mymsg{
                
                Spacer(minLength: 25)
                
                if msg.phto == nil{
                    
                    Text(msg.massage)
                        .foregroundColor(.black)
                        .padding(.all)
                        .background(Color.black.opacity(0.05))
                        .clipShape(ChatBubbleShape(mymsg: msg.Mymsg))
                }
                
                else{
                    
                    
                    Image(uiImage: UIImage(data: msg.phto!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 100)
                        .clipShape(ChatBubbleShape(mymsg: msg.Mymsg))
                }
                    
                
                Image(msg.profilepic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                
            }
            
            else{
                
                Image(msg.profilepic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                if msg.phto == nil{
                    
                    Text(msg.massage)
                        .foregroundColor(.black)
                        .padding(.all)
                        .background(Color.black.opacity(0.05))
                        .clipShape(ChatBubbleShape(mymsg: msg.Mymsg))
                }
                
                else{
                    
                    
                    Image(uiImage: UIImage(data: msg.phto!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 100)
                        .clipShape(ChatBubbleShape(mymsg: msg.Mymsg))
                }
                
               
                
                Spacer(minLength: 25)
                
                
            }
            
            
            
            
        }
        .id(msg.id)
        
        
    }
}

struct Message : Identifiable,Equatable {
    var id : Date
    var massage : String
    var Mymsg : Bool
    var profilepic : String
    var phto : Data?
    
}

class Messages : ObservableObject{
    @Published var messages : [Message] = []
    
    init() {
        let statas = ["A","B","C","D","E","F","G"]
        
        for i in 0..<statas.count{
            
            messages.append(Message(id: Date(), massage: statas[i], Mymsg: i % 2 == 0 ? false : true, profilepic: i % 2 == 0 ? "p1" : "p2"))
            
            
        }
    }
    
    func writemessage(id :Date,message : String,Mymsg : Bool,profilpixc : String,photo : Data?){
        
        
        messages.append(Message(id: id, massage: message, Mymsg: Mymsg, profilepic: profilpixc, phto: photo))
        
        
    }
    
    
}

struct ChatBubbleShape : Shape {
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: mymsg ? [.topLeft,.bottomLeft,.bottomRight] : [.topLeft,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}

struct CustomShape : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}
