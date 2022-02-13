//
//  CachedImageView.swift
//  SwiftUITest1
//
//  Created by Hyusein on 7.02.22.
//

import SwiftUI
import UIKit

enum LoadingState {
    case idle
    case loading
    case failed
    case loaded(UIImage)
}

struct CachedImageView: View {
    @ObservedObject var viewModel: AsyncImageViewModel
    
    init(urlString: String?) {
        viewModel = AsyncImageViewModel(urlString: urlString)
    }
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .loading:
            ProgressView()
        case .failed:
            Image(systemName: "photo").resizable()
                .scaledToFit()
        case .loaded(let image):
            Image(uiImage: image).resizable()
                .scaledToFit()
        }
    }
}

class AsyncImageViewModel: ObservableObject {
    
    @Published private(set) var state = LoadingState.idle
    private let urlString: String?
    
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        guard let urlString = urlString else {
            return
        }
        state = .loading
        
        ImageCache.publicCache.load(url: urlString, completion: {
            [weak self] result in
            switch result {
            case .success(let image):
                self?.state = .loaded(image)
            case .failure:
                self?.state = .failed
            }
        })
    }
}
