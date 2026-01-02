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
    
    // Constructors
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
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
                    .presentationDetents([.fraction(0.5)])
                }
                
                SpendView(
                    viewModel: viewModel.spendViewModel
                )
                .sheet(isPresented: $presentSpendItem) {
                    SpendItemView(
                        viewModel: SpendItemViewModel(
                            calendarService: viewModel.calendarService,
                            spendRepository: viewModel.spendRepository,
                            currencyFormatter: viewModel.currencyFormatter,
                            mode: {
                                if let spendItem = viewModel.spendItemToPresent {
                                    .existing(spendItem)
                                } else {
                                    .new
                                }
                            }()
                        )
                    )
                    .presentationDetents([.fraction(0.5)])
                }
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
                viewModel.setSpendItemToPresent(nil)
                presentSpendItem.toggle()
            }
            viewModel.spendViewModel.spendListViewModel.onSpendItemTapped = { spendItem in
                viewModel.setSpendItemToPresent(spendItem)
                presentSpendItem.toggle()
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .mock())
}
