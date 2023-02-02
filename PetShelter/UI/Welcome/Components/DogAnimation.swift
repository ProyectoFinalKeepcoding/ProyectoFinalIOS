//
//  DogAnimation.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 2/2/23.
//

import SwiftUI
import Lottie

struct DogAnimation: UIViewRepresentable {
    let lottieFile: String

        let animationView = LottieAnimationView()

        func makeUIView(context: Context) -> some UIView {
            let view = UIView(frame: .zero)

            animationView.animation = LottieAnimation.named(lottieFile)
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()

            view.addSubview(animationView)

            animationView.translatesAutoresizingMaskIntoConstraints = false
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

            return view
        }

        func updateUIView(_ uiView: UIViewType, context: Context) {
            //
        }
    
}

struct DogAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DogAnimation(lottieFile: "DogAnimation")
    }
}
