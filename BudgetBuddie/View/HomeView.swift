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
    @State private var presentSpendItem = false
    @State private var spendItemToEdit: SpendItem? = nil
    
    // Constructors
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(
            spacing: Spacing.2
        ) {
            BudgetBuddieBannerView()
            
            BudgetSummaryView(
                viewModel: viewModel.budgetSummaryViewModel
            )
            .sheet(isPresented: $presentSettings) {
                SettingsView(
                    viewModel: SettingsViewModel(
                        settingsService: viewModel.settingsService,
                        currencyFormatter: viewModel.currencyFormatter
                    )
                )
                .presentationDetents([.height(328.0)])
            }
            
            SpendView(
                viewModel: viewModel.spendViewModel
            )
            .ignoresSafeArea(.all, edges: .bottom)
            .sheet(isPresented: $presentSpendItem) {
                SpendItemView(
                    viewModel: SpendItemViewModel(
                        calendarService: viewModel.calendarService,
                        spendRepository: viewModel.spendRepository,
                        currencyFormatter: viewModel.currencyFormatter,
                        mode: .new
                    )
                )
                .presentationDetents([.height(256.0)])
            }
        }
        .padding(.top, Padding.2)
        .padding(.horizontal, Padding.2)
        .onAppear {
            // assign closures to facilitate presentables
            viewModel.budgetSummaryViewModel.onSettingsTapped = {
                presentSettings.toggle()
            }
            viewModel.spendViewModel.onNewSpendItemTapped = {
                spendItemToEdit = nil
                presentSpendItem.toggle()
            }
            viewModel.spendViewModel.onEditSpendItemTapped = { spendItem in
                spendItemToEdit = spendItem
                presentSpendItem.toggle()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .mock())
}
