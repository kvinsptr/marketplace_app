# 🛒 Marketplace App Flutter

Aplikasi marketplace berbasis Flutter dengan Firebase sebagai backend.  
Aplikasi ini mendukung tiga jenis pengguna:

- 👤 Buyer
- 🏪 Seller
- 🛡️ Admin

Project ini dibuat dengan arsitektur modular menggunakan Flutter + Riverpod + Firebase.

---

## ✨ Features

### 👤 Buyer

- Register & Login
- Melihat daftar produk
- Melihat detail produk
- Keranjang belanja
- Checkout
- Membuat pesanan
- Melihat status pesanan
- Chat dengan seller


### 🏪 Seller

- Register sebagai seller
- Seller dashboard
- Tambah produk
- Edit produk
- Hapus produk
- Melihat produk milik sendiri
- Melihat pesanan masuk


### 🛡️ Admin

- Admin dashboard
- User management
- Product management
- Order management
- Mengatur role user

---

## 🏗️ Tech Stack

### Frontend

- Flutter
- Dart
- Riverpod State Management


### Backend

- Firebase Authentication
- Cloud Firestore
- Firebase Storage


### Architecture

Menggunakan konsep:

```
Feature Based Architecture

lib/
 ├── core/
 ├── features/
 │    ├── auth/
 │    ├── product/
 │    ├── seller/
 │    ├── cart/
 │    ├── order/
 │    ├── chat/
 │    └── admin/
 └── main.dart
```

---

## 🔐 User Role

Role user disimpan pada Firestore:

Collection:

```
users
```

Example:

```json
{
  "uid": "user_id",
  "email": "user@email.com",
  "role": "buyer"
}
```

Role tersedia:

```
buyer
seller
admin
```

---

## 🚀 Installation

Clone repository:

```bash
git clone https://github.com/USERNAME/marketplace_app.git
```

Masuk folder:

```bash
cd marketplace_app
```

Install dependency:

```bash
flutter pub get
```

---

## 🔥 Firebase Setup

Project membutuhkan Firebase configuration.

Tambahkan:

```
firebase_options.dart
```

Kemudian setup:

```
Firebase Authentication
Cloud Firestore
Firebase Storage
```

Aktifkan:

- Email/Password Authentication
- Firestore Database

---

## ▶️ Run Project

Jalankan:

```bash
flutter run
```

Untuk Chrome:

```bash
flutter run -d chrome
```

---

## 📱 Screens

### Authentication

- Login
- Register


### Dashboard

Buyer:

```
Home
Product
Cart
Orders
Profile
```


Seller:

```
Seller Dashboard
Products
Orders
Chat
```


Admin:

```
Admin Dashboard
User Management
Product Management
Order Management
```

---

## 📂 Database Structure

### Users

```
users
 └── uid
      ├── email
      ├── role
      └── createdAt
```


### Products

```
products
 └── productId
      ├── name
      ├── price
      ├── description
      ├── imageUrl
      └── sellerId
```


### Orders

```
orders
 └── orderId
      ├── buyerId
      ├── sellerId
      ├── products
      ├── status
      └── createdAt
```

---

## 🧪 Development Status

Current progress:

✅ Authentication  
✅ Buyer role  
✅ Seller role  
✅ Admin dashboard  
✅ Product CRUD  
✅ User management  
✅ Order management  
🚧 Payment gateway  
🚧 Advanced chat system  
🚧 Notification system  


---

## 👨‍💻 Developer

Developed using:

Flutter + Firebase

---

## 📄 License

This project is for learning and development purposes.