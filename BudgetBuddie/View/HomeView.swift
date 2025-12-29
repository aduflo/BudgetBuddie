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
    
    // Constructors
    init(
        presentSettings: Bool = false,
        viewModel: HomeViewModel
    ) {
        self.presentSettings = presentSettings
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
                    viewModel: viewModel.settingsViewModel
                )
                .presentationDetents([.height(312.0)])
            }
            
            SpendView(
                viewModel: viewModel.spendViewModel
            )
            .ignoresSafeArea(.all, edges: .bottom)
            .sheet(isPresented: $presentNewSpendItem) {
                NewSpendItemView(
                    viewModel: .mock() // TODO: generate new one with selected date
                )
                .presentationDetents([.height(312.0)])
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear {
            // implement presentation closures
            viewModel.rundownViewModel.onSettingsTapped = {
                presentSettings.toggle()
            }
            viewModel.spendViewModel.onNewSpendItemTapped = {
                presentNewSpendItem.toggle()
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: .SettingsUpdated
            ),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.rundownViewModel.reloadData()
                }}
            }
        )
        .onReceive(
            NotificationCenter.default.publisher(
                for: .SelectedDateUpdated
            ),
            perform: { _ in
                Task { await MainActor.run {
                    viewModel.rundownViewModel.reloadData()
                }}
            }
        )
    }
}

#Preview {
    HomeView(viewModel: .mock())
}
