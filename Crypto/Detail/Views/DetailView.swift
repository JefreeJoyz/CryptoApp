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
            VStack(spacing: 20) {
                Text("123")
                    .frame(height: 130)
                overView
                Divider()
                overViewGrid
                
                additionalTitle
                Divider()
                additionalViewGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                DetailView(coin: dev.coin)
            }
        }
    }
}

extension DetailView {
    private var overView: some View {
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
}
