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
    @State private var presentSpendMonthSummary = false
    @State private var presentSpendHistory = false
    
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
                
                SpendListView(
                    viewModel: viewModel.spendListViewModel
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
                
                Button {
                    presentSpendHistory.toggle()
                } label: {
                    Text(Copy.spendHistoryButton) // TODO: come back to this to determine styling/copy/tint color
                }
                .padding(Padding.1)
                .roundedRectangleBackground(
                    cornerRadius: CornerRadius.1,
                    color: .gray.opacity(0.25)
                )
                .sheet(isPresented: $presentSpendHistory) {
                    SpendHistoryView(
                        viewModel: SpendHistoryViewModel(
                            spendRepository: viewModel.spendRepository,
                            currencyFormatter: viewModel.currencyFormatter
                        )
                    )
                    .presentationDetents([.fraction(0.75)])
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
            viewModel.spendListViewModel.onNewSpendItemTapped = {
                viewModel.setSpendItemToPresent(nil)
                presentSpendItem.toggle()
            }
            viewModel.spendListViewModel.onSpendItemTapped = { spendItem in
                viewModel.setSpendItemToPresent(spendItem)
                presentSpendItem.toggle()
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(for: .SpendRepositoryDidCommitStagedMonth),
            perform: { notification in
                guard let userInfo = notification.userInfo,
                      let month = userInfo[Notification.UserInfoKey.month] as? Int,
                      let year = userInfo[Notification.UserInfoKey.year] as? Int else {
                    return
                }
                
                Task { await MainActor.run {
                    viewModel.setSpendMonthSummaryParamsToPresent(
                        month: month,
                        year: year
                    )
                    presentSpendMonthSummary.toggle()
                }}
            }
        )
        .onReceive(
            NotificationCenter.default.publisher(for: .SpendRepositoryDidStageNewMonth),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.reloadData()
                }}
            }
        )
        .sheet(isPresented: $presentSpendMonthSummary) {
            if let params = viewModel.spendMonthSummaryParamsToPresent {
                SpendMonthSummaryView(
                    viewModel: SpendMonthSummaryViewModel(
                        spendRepository: viewModel.spendRepository,
                        month: params.month,
                        year: params.year
                    )
                )
                .presentationDetents([.fraction(0.75)])
            } else { EmptyView() }
        }
    }
}

#Preview {
    HomeView(
        viewModel: .mock()
    )
}
