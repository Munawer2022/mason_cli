# Mason CLI - Flutter Code Generation

A collection of Mason bricks for Flutter development with TDD (Test-Driven Development) support.

## 🚀 Quick Start

### 1. Install Mason CLI
```bash
dart pub global activate mason_cli
```

### 2. Add Bricks to Your Project

#### Option A: Add from Local Path (Recommended)
```bash
# Add bricks locally to your project
mason add mason_tdd --source path --path ./mason_tdd
mason add mason_tdd_folder --source path --path ./mason_tdd_folder
```

#### Option B: Add from Git Repository
```bash
# Add from GitHub repository
mason add --global mason_tdd --git-url https://github.com/Munawer2022/mason_cli.git --git-path mason_tdd --git-ref removeRepo
```

## 📦 Available Bricks

- **mason_tdd**: Complete TDD setup with Flutter architecture
- **mason_tdd_folder**: Folder structure generator for features

## 🛠️ Usage

### Generate New Brick with Hooks
```bash
mason new <BRICK_NAME> --hooks
```

### Generate Code from Bricks
```bash
# Generate to lib directory
mason make <BRICK_NAME> -o lib

# Generate with custom name
mason make <BRICK_NAME> --name hello -o lib
```

## 🔧 Management Commands

### List All Global Bricks
```bash
mason list --global
```

### Remove a Brick
```bash
mason remove -g <BRICK_NAME>
```

### Upgrade All Bricks
```bash
mason upgrade --global

- **Clean Architecture**: Follows Flutter best practices
- **TDD Support**: Built-in test structure
- **State Management**: Cubit/Bloc support
- **Navigation**: Custom navigation setup
- **Theming**: Complete theming system
- **Services**: Common services (location, payment, image picker)
- **Widgets**: Reusable UI components

## 📝 Example Usage

1. **Create a new feature:**
   ```bash
   mason make mason_tdd_folder --name user_profile -o lib/features
   ```

2. **Generate complete TDD setup:**
   ```bash
   mason make mason_tdd --name auth -o lib
   ```
