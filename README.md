# 🧱 Mason CLI - Flutter Code Generation

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)

A collection of **Mason bricks** for Flutter development with **TDD (Test-Driven Development)** support following Clean Architecture principles.

## 📦 Available Bricks

| Brick | Description | Install |
|-------|-------------|---------|
| **[mason_tdd](https://brickhub.dev/bricks/mason_tdd/)** | Complete Flutter architecture with Clean Architecture, Bloc, Dependency Injection, and Authentication | `mason add --global mason_tdd` |
| **mason_tdd_folder** | Feature folder generator with Cubit/Bloc setup | `mason add --global mason_tdd_folder` |

## 🚀 Quick Start

### Install Mason CLI

```bash
dart pub global activate mason_cli
```

### Add Bricks

```bash
# Add from BrickHub (Recommended)
mason add --global mason_tdd

# Or from Local Path
mason add mason_tdd --source path --path ./mason_tdd
mason add mason_tdd_folder --source path --path ./mason_tdd_folder

# Or from Git Repository
mason add --global mason_tdd --git-url https://github.com/munawerdev/mason_cli.git --git-path mason_tdd
```

### Generate Code

```bash
# Complete TDD setup
mason make mason_tdd

# Generate feature folder
mason make mason_tdd_folder --name user_profile -o lib/features
```

## ✨ Features

- ✅ **Clean Architecture** with Domain-Driven Design
- ✅ **State Management** with Flutter Bloc/Cubit
- ✅ **Dependency Injection** with GetIt
- ✅ **Network Layer** with Dio interceptors
- ✅ **Authentication System** with secure storage
- ✅ **Theming** and UI components library
- ✅ **Responsive Design** with flutter_screenutil
- ✅ **TDD Support** with built-in test structure

## 📚 Documentation

- **mason_tdd**: [View on BrickHub](https://brickhub.dev/bricks/mason_tdd/)
- **mason_tdd README**: [Full Documentation](./mason_tdd/README.md)

## 🔧 Management Commands

```bash
# List all global bricks
mason list --global

# Remove a brick
mason remove -g mason_tdd

# Upgrade all bricks
mason upgrade --global
```

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

MIT License - see [LICENSE](./LICENSE) for details.

---

**Powered by [Mason](https://github.com/felangel/mason) 🧱**
