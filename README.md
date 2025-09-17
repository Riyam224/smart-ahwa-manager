# ☕🍵 Smart Ahwa Manager 🍵☕

This app was designed for Ahwa (traditional Cairo coffee shop) owners and managers.
The goal is to help them:
	•	Add and manage customer drink orders
	•	Track pending vs. completed ones
	•	Generate daily sales reports (total orders + top-selling drinks)

So they can streamline operations and optimize their business.

⸻

## 🎯 Project Idea

Running an Ahwa can be messy and inefficient:
	•	Waiters take notes on paper that often get lost
	•	It’s hard to track which orders are pending vs. completed
	•	Managers lack visibility into the best-selling drinks of the day

Smart Ahwa Manager solves this by providing a simple digital dashboard where managers can:
	•	📋 Record and monitor all drink orders
	•	📊 Track pending vs. completed orders in real time
	•	📌 Generate daily sales reports with totals and top-selling drinks

This project also demonstrates clean code practices, applying OOP principles (Encapsulation, Inheritance, Polymorphism, Abstraction) and SOLID design principles in Flutter.

⸻

## 🔄 Workflow 
	1.	👤 A customer places a drink order with the waiter.
	2.	🖥️ The manager or staff records the order in the app (customer name, drink, special notes).
	3.	📋 The order is added to the Pending Orders list.
	4.	📊 The dashboard updates live with counts for Pending, Completed, and Total orders.
	5.	✅ Once served, the manager (or staff) marks the order as Completed.
	6.	📌 At the end of the day, the manager generates a Daily Report, which shows:
	•	Total number of orders
	•	Top-selling drinks
---


## 📸 Screenshots

### 🏠 Home Screen  

<img src="screenshots/home.png" width="300" />

### 📊 Daily Report  

<img src="screenshots/daily_report.png" width="300" />

---

## 📂 Project Structure

lib/
 ├── models/
 │   ├── drink.dart
 │   └── order.dart
 ├── services/
 │   ├── order_service.dart
 │   └── report_service.dart
 ├── pages/
 │   └── order_view.dart
 └── main.dart

## 📌 Features

	•	➕ Add new orders with:
	•	Customer name
	•	Drink type (e.g., Coffee, Green Tea, Hibiscus Tea)
	•	Special instructions (e.g., extra mint)
	•	✅ Mark orders as completed
	•	📊 Dashboard showing pending, completed, and total orders
	•	📝 Daily report with:
	•	Total number of orders
	•	Top-selling drinks

---

## 🏗 Architecture & Flow

The app follows a simple **MVC-like separation**:

UI (OrderPage)
↓
OrderService (manages orders)
↓
ReportService (generates reports)
↓
Models (Drink, Order)

---

## 🔑 SOLID Principles Applied

- **S – Single Responsibility Principle (SRP):**  
  - `OrderService` only manages orders  
  - `ReportService` only generates reports  

- **O – Open/Closed Principle (OCP):**  
  - Add new drinks (e.g., `TurkishCoffee`) without modifying existing code  

- **L – Liskov Substitution Principle (LSP):**  
  - Any subclass of `Drink` (Coffee, Tea, etc.) can replace another safely  

- **I – Interface Segregation Principle (ISP):**  
  - Code split into small, focused classes instead of "fat interfaces"  

- **D – Dependency Inversion Principle (DIP):**  
  - Services depend on **abstractions** (`Drink` is abstract) instead of concrete classes  

---

## 🛠 Object-Oriented Concepts Used

- **Encapsulation** → `_isCompleted` is private and exposed via getter/setter  
- **Inheritance** → `Drink` is extended by `Coffee`, `GreenTea`, `HibiscusTea`  
- **Polymorphism** → All drinks behave the same but hold different values (name/price)  
- **Abstraction** → `Drink` is abstract, forcing subclasses to define drink details  

---

## 🚀 Getting Started

Clone the repo and run the project:

```bash
git clone https://github.com/Riyam224/smart-ahwa-manager.git
cd smart-ahwa-manager
flutter pub get
flutter run




⸻

