//
//  HomeScreen.swift
//  BudgetIsLife
//
//  Created by Adam Duflo on 12/22/25.
//

import SwiftUI

struct HomeScreen: View {
    // Instance vars
    @State private var screenModel: HomeScreenModel
    @State private var presentSettings = false
    @State private var presentSpendItem = false
    @State private var presentSpendMonthlyHistory = false
    @State private var presentOnboarding = false
    @State private var presentSpendMonthSummary = false
    
    // Constructors
    init(
        screenModel: HomeScreenModel
    ) {
        self.screenModel = screenModel
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(
                alignment: .center,
                spacing: Spacing.2
            ) {
                headerView
                summaryView
                listView
                footerView
            }
            .padding(.bottom, Padding.4)
        }
        .scrollIndicators(.hidden)
        .padding(.top, Padding.half)
        .padding(.horizontal, Padding.2)
        .ignoresSafeArea(.container, edges: .bottom)
        .onAppear {
            setupHandlers()
        }
        .onReceive(
            NotificationCenter.default.publisher(for: .SpendRepositoryDidCommitStagedMonth),
            perform: { notification in
                guard let userInfo = notification.userInfo,
                      let date = userInfo[Notification.UserInfoKey.date] as? Date else {
                    return
                }
                
                Task { await MainActor.run {
                    screenModel.setSpendMonthSummaryDateToPresent(
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
                    screenModel.reloadData()
                    setupHandlers()
                }}
            }
        )
        .sheet(isPresented: $presentOnboarding) {
            OnboardingScreen(
                screenModel: OnboardingScreenModel(
                    userDefaults: screenModel.userDefaults
                )
            )
            .presentationDetents([.large])
        }
        .sheet(isPresented: $presentSpendMonthSummary) {
            if let date = screenModel.spendMonthSummaryDateToPresent {
                SpendMonthSummaryScreen(
                    screenModel: SpendMonthSummaryScreenModel(
                        spendRepository: screenModel.spendRepository,
                        currencyFormatter: screenModel.currencyFormatter,
                        date: date
                    )
                )
                .presentationDetents([.fraction(1/3)])
            } else { EmptyView() }
        }
    }
    
    var headerView: some View {
        AppBannerView()
            .onTapGesture {
                presentOnboarding = true
            }
    }
    
    var summaryView: some View {
        SpendSummaryView(
            viewModel: screenModel.spendSummaryViewModel
        )
        .sheet(isPresented: $presentSettings) {
            SettingsScreen(
                viewModel: SettingsScreenModel(
                    settingsService: screenModel.settingsService,
                    currencyFormatter: screenModel.currencyFormatter
                )
            )
            .presentationDetents([.large])
        }
    }
    
    var listView: some View {
        SpendListView(
            viewModel: screenModel.spendListViewModel
        )
        .sheet(isPresented: $presentSpendItem) {
            SpendItemScreen(
                screenModel: SpendItemScreenModel(
                    calendarService: screenModel.calendarService,
                    spendRepository: screenModel.spendRepository,
                    currencyFormatter: screenModel.currencyFormatter,
                    mode: {
                        if let spendItem = screenModel.spendItemToPresent {
                            .existing(spendItem)
                        } else {
                            .new
                        }
                    }()
                )
            )
            .presentationDetents([.fraction(1/2)])
        }
    }
    
    var footerView: some View {
        Button {
            presentSpendMonthlyHistory.toggle()
        } label: {
            HStack(
                spacing: Spacing.half
            ) {
                Image(systemName: SystemImage.clockArrowTriangleheadCounterclockwiseRotate90)
                Text(Copy.monthlyHistoryButton)
            }
            .foregroundStyle(.foregroundPrimary)
            .padding(Padding.1)
            .roundedRectangleBackground(
                cornerRadius: CornerRadius.1,
                color: .backgroundSecondary
            )
        }
        .sheet(isPresented: $presentSpendMonthlyHistory) {
            SpendMonthlyHistoryScreen(
                screenModel: SpendMonthlyHistoryScreenModel(
                    spendRepository: screenModel.spendRepository,
                    currencyFormatter: screenModel.currencyFormatter
                )
            )
            .presentationDetents([.fraction(3/4)])
        }
    }
}

// MARK: Private interface
private extension HomeScreen {
    func setupHandlers() {
        // flip onboarding presentation if need be
        presentOnboarding = screenModel.didOnboardOnce == false
        
        // assign closures to facilitate presentables
        screenModel.spendSummaryViewModel.onSettingsTapped = {
            presentSettings.toggle()
        }
        screenModel.spendListViewModel.onNewSpendItemTapped = {
            screenModel.setSpendItemToPresent(nil)
            presentSpendItem.toggle()
        }
        screenModel.spendListViewModel.onSpendItemTapped = { spendItem in
            screenModel.setSpendItemToPresent(spendItem)
            presentSpendItem.toggle()
        }
    }
}

#Preview("Light Mode") {
    HomeScreen(
        screenModel: .mock()
    )
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    HomeScreen(
        screenModel: .mock()
    )
    .preferredColorScheme(.dark)
}
