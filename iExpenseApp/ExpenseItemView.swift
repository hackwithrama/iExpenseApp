//
//  ExpenseItemView.swift
//  iExpenseApp
//
//  Created by Ramachandran Varadaraju on 04/07/24.
//

import SwiftUI

struct ExpenseItemView: View {
    let expenseName: String
    let expenseType: String
    let expenseAmount: Double
    let amountColor: Color = .black

    var body: some View {
        HStack(spacing: 10){
            VStack(alignment: .leading){
                Text(expenseName)
                    .font(.title3)
                Text(expenseType)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(expenseAmount, format: .currency(code: "INR"))
                .foregroundStyle(expenseAmount < 10 ? .red : .green)
                .fontWeight(.semibold)
                
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ExpenseItemView(expenseName: "Car Insurance", expenseType: "Personal", expenseAmount: 2345.50)
}
