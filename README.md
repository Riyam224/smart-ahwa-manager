# ☕ Smart Ahwa Manager

A Flutter app for managers of a traditional Cairo Ahwa (coffee shop).
Instead of scribbled notes and confusion, this app helps the manager track all drink orders, see pending vs. completed ones, and generate daily sales insights.

This project also demonstrates OOP concepts and SOLID principles in Flutter with clean, modular code.practical way.  

---

## 🎯 Project Idea

Managing an Ahwa is often messy:
	•	Waiters take notes on paper that get lost.
	•	It’s hard to know which orders are pending vs. completed.
	•	Managers don’t know which drink sells the most in a day.

This app solves that by giving the manager a clear dashboard to:
	•	Monitor all customer drink orders
	•	Track pending vs. completed orders in real time
	•	Generate daily reports of total sales and top-selling drinks

It also applies:

- Clean code structure  
- OOP principles (Encapsulation, Inheritance, Polymorphism, Abstraction)  
- SOLID design principles  

---

## 🔄 Workflow (Manager’s Perspective)
	1.	👤 A customer places a drink order with the waiter.
	2.	🖥️ The manager (using the app) records the order (name, drink, special notes).
	3.	📋 The order is stored in the Pending Orders list.
	4.	📊 The dashboard updates live (Pending, Completed, Total orders).
	5.	✅ Once served, the manager (or staff) marks the order as Completed.
	6.	📌 At the end of the day, the manager taps Daily Report to see:
	•	Total number of orders
	•	The most popular (top-selling) drinks

 ---

## 📸 Screenshots

### 🏠 Home Screen  

<img src="screenshots/home.png" width="300" />

### 📊 Daily Report  

<img src="screenshots/daily_report.png" width="300" />

---

📂 Project Structure

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

- ➕ Add new orders with:
  - Customer name  
  - Drink type (Coffee, Green Tea, Hibiscus Tea, etc.)  
  - Special instructions  
- ✅ Mark orders as **completed**  
- 📊 Dashboard showing **pending, completed, and total orders**  
- 📝 Generate a **daily report** with:
  - Total number of orders  
  - Top-selling drinks  

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

