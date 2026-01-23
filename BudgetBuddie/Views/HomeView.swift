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
                    .presentationDetents([.fraction(1/2)])
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
                    .presentationDetents([.fraction(1/2)])
                }
                
                Button {
                    presentSpendHistory.toggle()
                } label: {
                    Image(systemName: SystemImage.clockArrowTriangleheadCounterclockwiseRotate90)
                    Text(Copy.historyButton)
                }
                .tint(.black)
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
                    .presentationDetents([.fraction(3/4)])
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
                      let date = userInfo[Notification.UserInfoKey.date] as? Date else {
                    return
                }
                
                Task { await MainActor.run {
                    viewModel.setSpendMonthSummaryDateToPresent(
                        date: date
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
            if let date = viewModel.spendMonthSummaryDateToPresent {
                SpendMonthSummaryView(
                    viewModel: SpendMonthSummaryViewModel(
                        spendRepository: viewModel.spendRepository,
                        currencyFormatter: viewModel.currencyFormatter,
                        date: date
                    )
                )
                .presentationDetents([.fraction(1/3)])
            } else { EmptyView() }
        }
    }
}

#Preview {
    HomeView(
        viewModel: .mock()
    )
}
