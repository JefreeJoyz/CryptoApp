//
//  DetailView.swift
//  Crypto
//
//  Created by Eugene Yakushev on 04.07.2022.
//

import SwiftUI

// Эта вьюха-прокладка нужна для того, что бы наша DetailView() не инициилизировалась раньше времени
struct DetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            // Т.к. coin у нас опционал - безопасно извлекаем
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    // мы не можем иниировать DetailViewModel, т.к. неоткуда взять аргумент coin. Поэтому мы делаем это через init
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
                VStack {
                    ChartView(coin: vm.coin)
                        .padding(.vertical)
                    overViewTitle
                    Divider()
                    descriptionSection
                    overViewGrid
                    additionalTitle
                    Divider()
                    additionalViewGrid
                    websiteSection
            }
            .padding()
        }
        .background(Color.theme.background.ignoresSafeArea())
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingitems
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    
    private var navigationBarTrailingitems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
            .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalViewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty {
                VStack (alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var websiteSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString) {
                Link("website", destination: url)
            }
            
            if let redditString = vm.redditURL,
               let url = URL(string: redditString) {
                Link("reddit", destination: url)
            }
            
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
