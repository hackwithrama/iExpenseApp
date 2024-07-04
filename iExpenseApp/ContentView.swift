//
//  ContentView.swift
//  iExpenseApp
//
//  Created by Ramachandran Varadaraju on 04/07/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses{
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "Items"){
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: data){
                items = decoded
                return
            }
        }
        
        items = []
    }
    
    func removeRow(at offSet: IndexSet){
        items.remove(atOffsets: offSet)
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showAddExpense = false
    @State private var amountColor: Color = .black
    
    
    var body: some View {
        NavigationStack{
            List{
                GroupBox{
                    DisclosureGroup("Business expenses"){
                        ForEach(expenses.items.filter{expense in
                            expense.type == "Business"
                        }){item in
                            ExpenseItemView(expenseName: item.name, expenseType: item.type, expenseAmount: item.amount)
                        }
                        .onDelete(perform: expenses.removeRow)
                    }
                }
                
                GroupBox{
                    DisclosureGroup("Personal expenses"){
                        ForEach(expenses.items.filter{expense in
                            expense.type == "Personal"
                        }){item in
                            ExpenseItemView(expenseName: item.name, expenseType: item.type, expenseAmount: item.amount)
                        }
                        .onDelete(perform: expenses.removeRow)
                    }
                }
                
                //ForEach(expenses.items){item in
                //    HStack(spacing: 10){
                //        VStack(alignment: .leading){
                //            Text(item.name)
                //                .font(.title2)
                //            Text(item.type)
                //                .font(.footnote)
                //                .foregroundColor(.secondary)
                //        }
                //        Spacer()
                //        Text(item.amount, format: .currency(code: "INR"))
                //            .foregroundStyle(item.amount < 10 ? .red : .green)
                //            .fontWeight(.semibold)
                //
                //    }
                //}
                //.onDelete(perform: expenses.removeRow)
            }
            .navigationTitle("iExpense")
            .toolbar{
                    Button{
                        showAddExpense.toggle()
                    }label: {
                        Text("Add expense")
                            .font(.system(size: 20))
                    }
                    .sheet(isPresented: $showAddExpense){
                        AddExpenseForm(expenses: expenses)
                            .presentationDetents([.large])
                    }
                    
                    if expenses.items.count > 0 {
                        EditButton()
                            .font(.system(size: 20))
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
