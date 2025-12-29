//
//  HomeView.swift
//  BudgetBuddie
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct HomeView: View {
    // Instance vars
    @State private var viewModel: HomeViewModel
    @State private var presentSettings = false
    @State private var presentNewSpendItem = false
    
    @Environment(\.settingsService) var settingsService
    @Environment(\.calendarService) var calendarService
    @Environment(\.spendRepository) var spendRepository
    @Environment(\.currencyFormatter) var currencyFormatter
    
    // Constructors
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            spacing: 16.0
        ) {
            BudgetBuddieBannerView()
            
            BudgetRundownView(
                viewModel: viewModel.rundownViewModel
            )
            .sheet(isPresented: $presentSettings) {
                SettingsView(
                    viewModel: SettingsViewModel(
                        settingsService: settingsService,
                        currencyFormatter: currencyFormatter
                    )
                )
                .presentationDetents([.height(312.0)])
            }
            
            SpendView(
                viewModel: viewModel.spendViewModel
            )
            .ignoresSafeArea(.all, edges: .bottom)
            .sheet(isPresented: $presentNewSpendItem) {
                NewSpendItemView(
                    viewModel: NewSpendItemViewModel(
                        calendarService: calendarService,
                        spendRepository: spendRepository,
                        currencyFormatter: currencyFormatter
                    )
                )
                .presentationDetents([.height(312.0)])
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear {
            // assign closures to facilitate presentables
            viewModel.rundownViewModel.onSettingsTapped = {
                presentSettings.toggle()
            }
            viewModel.spendViewModel.onNewSpendItemTapped = {
                presentNewSpendItem.toggle()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .mock())
}
