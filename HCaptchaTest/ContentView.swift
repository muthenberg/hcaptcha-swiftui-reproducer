//
//  ContentView.swift
//  HCaptchaTest
//
//  Created by Klemens Muthmann on 22.07.22.
//

import SwiftUI
import HCaptcha

// Wrapper-view to provide UIView instance
struct UIViewWrapperView : UIViewRepresentable {
    var uiview = UIView()

    func makeUIView(context: Context) -> UIView {
        return uiview
    }

    func updateUIView(_ view: UIView, context: Context) {
    }
}

// Example of hCaptcha usage
struct HCaptchaView: View {
    private(set) var hcaptcha: HCaptcha!

    let placeholder = UIViewWrapperView()

    var body: some View {
        VStack{
            placeholder.frame(width: 400, height: 400, alignment: .center)
            Button(
                "validate",
                action: {
                    hcaptcha.validate(on: placeholder.uiview) { result in
                        print(result)
                    }
                }
            )
            .padding()
            .navigationTitle("HCaptcha")
            .navigationBarTitleDisplayMode(.inline)
        }
    }


    init() {
        guard let baseURL = URL(string: "http://localhost") else {
            fatalError()
        }

        hcaptcha = try! HCaptcha(apiKey: "<Add your Site Key Here>", baseURL: baseURL)
        let hostView = self.placeholder.uiview
        hcaptcha.configureWebView { webview in
            webview.frame = hostView.bounds
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: HCaptchaView(), label: {
                Text("HCaptcha")
            })
            .navigationTitle("Main Page")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
