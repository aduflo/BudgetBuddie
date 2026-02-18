//
//  SpendItemScreenModelTests.swift
//  BudgieBuddieTests
//
//  Created by Adam Duflo on 2/18/26.
//

import Foundation
import Testing
@testable import BudgieBuddie

@MainActor
struct SpendItemScreenModelTests {
    // MARK: - init
    @Test func test_init_withMode_new() {
        // Setup
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        
        // Verification
        #expect(vm.title == "New Spend Item")
        #expect(vm.amount == 0.0)
        #expect(vm.note == "")
    }
    
    @Test func test_init_withMode_existing_with_note() {
        // Setup
        let spendItem = SpendItem(
            dayId: UUID(),
            amount: 13.37,
            note: "Leet"
        )
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            mode: .existing(spendItem)
        )
        
        // Verification
        #expect(vm.title == "Edit Spend Item")
        #expect(vm.amount == spendItem.amount)
        #expect(vm.note == spendItem.note)
    }
    
    @Test func test_init_withMode_existing_without_note() {
        // Setup
        let spendItem = SpendItem(
            dayId: UUID(),
            amount: 13.37,
            note: nil
        )
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            mode: .existing(spendItem)
        )
        
        // Verification
        #expect(vm.title == "Edit Spend Item")
        #expect(vm.amount == spendItem.amount)
        #expect(vm.note == "")
    }
    
    // MARK: - setAmount()
    @Test func test_setAmount_with_value() {
        // Setup
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        let amount: Decimal = 13.37
        
        // Scenario
        vm.setAmount(amount)
        
        // Verification
        #expect(vm.amount == amount)
    }
    
    @Test func test_setAmount_without_value() {
        // Setup
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        
        // Scenario
        vm.setAmount(nil)
        
        // Verification
        #expect(vm.amount == 0.0)
    }
    
    // MARK: - setNote()
    @Test func test_setNote() {
        // Setup
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: MockSpendRepository(),
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        let note = "Leet"
        
        // Scenario
        vm.setNote(note)
        
        // Verification
        #expect(vm.note == note)
    }
    
    // MARK: - delete()
    @Test func test_delete_withMode_new() {
        // Setup
        let spendRepository = MockSpendRepository()
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        
        // Scenario
        let delete = vm.delete()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error == nil)
        #expect(delete == false)
    }
    
    @Test func test_delete_withMode_existing_valid() {
        // Setup
        let spendRepository = MockSpendRepository()
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .existing(.mock())
        )
        
        // Scenario
        let delete = vm.delete()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error == nil)
        #expect(delete == true)
        #expect(spendRepository.deleteItem_value != nil)
    }
    
    @Test func test_delete_withMode_existing_invalid() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.deleteItem_throwValue = SpendRepositoryError.deleteItemFailed
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .existing(.mock())
        )
        
        // Scenario
        let delete = vm.delete()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error != nil)
        #expect(delete == false)
        #expect(spendRepository.deleteItem_value == nil)
    }
    
    // MARK: - save()
    @Test func test_save_withMode_new_valid_with_note() {
        // Setup
        let spendRepository = MockSpendRepository()
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        let amount: Decimal = 1.0
        vm.setAmount(amount)
        let note = "yar yar"
        vm.setNote(note)
        
        // Scenario
        let save = vm.save()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error == nil)
        #expect(save == true)
        #expect(spendRepository.saveItem_value?.amount == amount)
        #expect(spendRepository.saveItem_value?.note == note)
    }
    
    @Test func test_save_withMode_new_valid_without_note() {
        // Setup
        let spendRepository = MockSpendRepository()
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        let amount: Decimal = 1.0
        vm.setAmount(amount)
        vm.setNote("")
        
        // Scenario
        let save = vm.save()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error == nil)
        #expect(save == true)
        #expect(spendRepository.saveItem_value?.amount == amount)
        #expect(spendRepository.saveItem_value?.note == nil)
    }
    
    @Test func test_save_withMode_existing_valid_newAmount() {
        // Setup
        let spendItem: SpendItem = .mock()
        let spendRepository = MockSpendRepository()
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .existing(spendItem)
        )
        let amount: Decimal = 34.43
        vm.setAmount(amount)
        
        // Scenario
        let save = vm.save()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error == nil)
        #expect(save == true)
        if case let .existing(item) = vm.mode {
            #expect(item.amount != amount)
        } else {
            Issue.record("could note access existing item")
        }
        #expect(spendRepository.saveItem_value?.amount == amount)
        #expect(spendRepository.saveItem_value?.note == vm.note)
    }
    
    @Test func test_save_withMode_existing_valid_newNote() {
        // Setup
        let spendItem: SpendItem = .mock()
        let spendRepository = MockSpendRepository()
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .existing(spendItem)
        )
        let note = "yar yar"
        vm.setNote(note)
        
        // Scenario
        let save = vm.save()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error == nil)
        #expect(save == true)
        if case let .existing(item) = vm.mode {
            #expect(item.note != note)
        } else {
            Issue.record("could note access existing item")
        }
        #expect(spendRepository.saveItem_value?.amount == vm.amount)
        #expect(spendRepository.saveItem_value?.note == note)
    }
    
    @Test func test_save_invalid_amount() {
        // Setup
        let spendRepository = MockSpendRepository()
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        vm.setAmount(0.0)
        
        // Scenario
        let save = vm.save()
        
        // Verification
        #expect(vm.requiredFieldWarningText != nil)
        #expect(vm.error == nil)
        #expect(save == false)
        #expect(spendRepository.saveItem_value == nil)
    }
    
    @Test func test_save_invalid_errored() {
        // Setup
        let spendRepository = MockSpendRepository()
        spendRepository.saveItem_throwValue = SpendRepositoryError.saveItemFailed
        let vm = SpendItemScreenModel(
            calendarService: MockCalendarService(),
            spendRepository: spendRepository,
            currencyFormatter: CurrencyFormatter(),
            mode: .new
        )
        vm.setAmount(1.0)
        
        // Scenario
        let save = vm.save()
        
        // Verification
        #expect(vm.requiredFieldWarningText == nil)
        #expect(vm.error != nil)
        #expect(save == false)
        #expect(spendRepository.saveItem_value == nil)
    }
}
