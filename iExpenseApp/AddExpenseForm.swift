//
//  AddExpenseForm.swift
//  iExpenseApp
//
//  Created by Ramachandran Varadaraju on 04/07/24.
//

import SwiftUI

struct AddExpenseForm: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Form{
                    Section("Expense name") {
                        TextField(text: $name) {
                            Text("Enter your expense")
                        }
                    }
                    
                    Picker("Select expense type", selection: $type){
                        ForEach(types, id: \.self){item in
                            Text(item)
                        }
                    }
                    
                    Section("Expense amount"){
                        TextField("Amount", value: $amount, format: .currency(code: "INR"))
                            .keyboardType(.decimalPad)
                    }
                    
                }
            }
            .toolbar{
                    Button{
                        let expense = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(expense)
                        dismiss()
                    }label: {
                        Text("Save")
                            .font(.system(size: 20))
                            .disabled((name != "" && amount != 0.0) ? false : true)
                    }
                    
                    Button{
                        dismiss()
                    }label: {
                        Text("Close")
                            .font(.system(size: 20))
                    }
            }
        }
    }
}

#Preview {
    AddExpenseForm(expenses: Expenses())
}
