# 🏆 Terraform CTF Challenge Solutions

> **A comprehensive, production-ready Terraform project demonstrating best practices through gamified learning**

This repository contains complete solutions for all 8 Terraform CTF (Capture The Flag) challenges, showcasing advanced Terraform concepts, modular design, and infrastructure-as-code best practices.

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?logo=terraform)](https://www.terraform.io/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Challenges](#challenges)
- [Configuration](#configuration)
- [Usage](#usage)
- [Outputs](#outputs)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 Overview

This project is a complete solution set for the Terraform CTF Challenge Provider, designed to teach Terraform concepts through hands-on practice. Each challenge focuses on specific Terraform features and best practices.

### 🌟 Key Features

- ✅ **8 Progressive Challenges** - From beginner to advanced concepts
- ✅ **Modular Architecture** - Clean separation of concerns
- ✅ **Best Practices** - Production-ready code structure
- ✅ **Comprehensive Documentation** - Inline comments and detailed README
- ✅ **Hint System** - Optional help with point penalties
- ✅ **Bonus Puzzles** - Extra challenges for advanced learners
- ✅ **Full Automation** - Makefile and helper scripts included

### 📊 Scoring

| Category | Total Points | Challenges |
|----------|-------------|------------|
| **Beginner** | 450 | 3 challenges |
| **Intermediate** | 900 | 3 challenges |
| **Advanced** | 900 | 2 challenges |
| **Total** | **2,250** | **8 challenges** |

---

## 🔧 Prerequisites

### Required Software

| Tool | Version | Installation |
|------|---------|--------------|
| **Terraform** | >= 1.0 | [Download](https://www.terraform.io/downloads) |
| **Git** | Latest | [Download](https://git-scm.com/downloads) |
| **Make** | Latest (optional) | Usually pre-installed on Unix systems |

### Terraform Provider

This project uses the custom CTF Challenge Provider:

```hcl
provider "ctfchallenge" {
  source  = "OMGhozlan/ctfchallenge"
  version = "1.0.2"
}
```

### System Requirements

- **OS**: Linux, macOS, or Windows
- **Memory**: 512 MB minimum
- **Disk Space**: 100 MB

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/terraform-ctf-solutions.git
cd terraform-ctf-solutions
```

### 2. Configure Your Player Name

```bash
# Copy the example configuration
cp terraform.tfvars.example terraform.tfvars

# Edit with your preferred editor
nano terraform.tfvars
```

Update the `player_name` variable:

```hcl
player_name = "YourName"
```

### 3. Initialize Terraform

```bash
terraform init
```

Expected output:
```
Initializing modules...
Initializing provider plugins...
- Finding OMGhozlan/ctfchallenge versions matching "1.0.2"...
- Installing OMGhozlan/ctfchallenge v1.0.2...

Terraform has been successfully initialized!
```

### 4. Run the Challenges

```bash
# Preview changes
terraform plan

# Apply all challenges
terraform apply

# Confirm with 'yes'
```

### 5. View Your Results

```bash
# Overall summary
terraform output summary

# Detailed results
terraform output challenge_results

# Completion percentage
terraform output completion_percentage
```

---

## 📁 Project Structure

```
terraform-ctf-solutions/
├── 📄 README.md                    # This file
├── 📄 versions.tf                  # Provider requirements
├── 📄 main.tf                      # Main configuration
├── 📄 variables.tf                 # Input variables
├── 📄 locals.tf                    # Local values
├── 📄 outputs.tf                   # Output definitions
├── 📄 terraform.tfvars             # Your configuration (git-ignored)
├── 📄 terraform.tfvars.example     # Example configuration
├── 📄 .gitignore                   # Git ignore rules
├── 📄 Makefile                     # Helper commands
│
├── 📁 modules/
│   ├── 📁 challenges/              # Challenge solutions module
│   │   ├── main.tf                # Module initialization
│   │   ├── variables.tf           # Module inputs
│   │   ├── locals.tf              # Module-specific locals
│   │   ├── outputs.tf             # Module outputs
│   │   └── challenges.tf          # All challenge implementations
│   │
│   ├── 📁 puzzles/                 # Bonus puzzles module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── xor-puzzle.tf          # XOR puzzle implementation
│   │
│   └── 📁 network-example/         # Example module for Module Master
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
│
└── 📁 docs/
    └── README.md                   # Additional documentation
```

---

## 🎮 Challenges

### Challenge 1: Terraform Basics (100 points)
**Difficulty**: 🟢 Beginner  
**Category**: Fundamentals  
**Concepts**: Resource dependencies, `depends_on`, execution order

Learn how Terraform manages resource dependencies and execution order by creating a chain of dependent resources.

**Solution Approach**:
- Create 3+ resources with explicit dependencies
- Use `depends_on` to control execution order
- Submit resource IDs as proof of work

---

### Challenge 2: Expression Expert (350 points)
**Difficulty**: 🟡 Intermediate  
**Category**: Expressions  
**Concepts**: Functions, string manipulation, hashing, encoding

Master Terraform's expression syntax and built-in functions by chaining operations.

**Required Computation**:
```hcl
base64encode(sha256("terraform" + "expressions" + "rock"))
```

**Functions Used**:
- `join()`, `sha256()`, `base64encode()`
- String concatenation
- Function composition

---

### Challenge 3: State Secrets (200 points)
**Difficulty**: 🟢 Beginner  
**Category**: State Management  
**Concepts**: Terraform state, resource tracking

Understand how Terraform tracks infrastructure state and discover the "magic number."

**Hint**: *"The answer to life, the universe, and everything..."* 🌌

---

### Challenge 4: Module Master (400 points)
**Difficulty**: 🔴 Advanced  
**Category**: Modules  
**Concepts**: Module composition, outputs, reusability

Create and use Terraform modules effectively, demonstrating code reuse and abstraction.

**Skills Demonstrated**:
- Module creation
- Module inputs and outputs
- Cross-module references
- Module composition patterns

---

### Challenge 5: Dynamic Blocks (300 points)
**Difficulty**: 🟡 Intermediate  
**Category**: Advanced Syntax  
**Concepts**: Dynamic blocks, meta-arguments

Master the `dynamic` block feature for generating multiple nested blocks programmatically.

**Requirement**: Generate 5+ dynamic blocks from configuration data

---

### Challenge 6: For-Each Wizard (250 points)
**Difficulty**: 🟡 Intermediate  
**Category**: Loops  
**Concepts**: `for_each`, resource iteration

Use the `for_each` meta-argument to create multiple similar resources elegantly.

**Required Items**: `alpha`, `beta`, `gamma`, `delta`

---

### Challenge 7: Data Source Detective (150 points)
**Difficulty**: 🟢 Beginner  
**Category**: Data Sources  
**Concepts**: Data sources, filtering, querying

Query and filter data sources effectively to extract specific information.

**Required Result**: Filter count = 7

---

### Challenge 8: Cryptographic Compute (500 points)
**Difficulty**: 🔴 Advanced  
**Category**: Functions  
**Concepts**: Cryptographic functions, function chaining

Use Terraform's cryptographic and hashing functions to solve complex puzzles.

**Required Computation**:
```hcl
md5(sha256("terraform_ctf_11_2025"))
```

---

### 🎁 Bonus: XOR Puzzle
**Objective**: Find 5 numbers whose XOR equals 0

**Hint**: Properties of XOR
- `a XOR a = 0` (self-cancellation)
- `a XOR 0 = a` (identity)
- XOR is commutative and associative

**Reward**: Secret flag 🏴

---

## ⚙️ Configuration

### Essential Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `player_name` | string | `"anonymous"` | Your player name |
| `enable_hints` | bool | `false` | Enable hint system |
| `hint_levels` | map(number) | `{...}` | Hint levels (0-2) per challenge |
| `enable_challenges` | object | `{...}` | Enable/disable specific challenges |
| `tags` | map(string) | `{...}` | Common resource tags |

### Example Configuration

```hcl
# terraform.tfvars

player_name = "Alice"

# Enable hints (costs points!)
enable_hints = true
hint_levels = {
  terraform_basics      = 1  # Medium hint
  expression_expert     = 2  # Detailed hint
  cryptographic_compute = 0  # Minimal hint
}

# Selectively enable challenges
enable_challenges = {
  terraform_basics      = true
  expression_expert     = true
  state_secrets         = false  # Skip this one
  module_master         = true
  dynamic_blocks        = true
  for_each_wizard       = true
  data_source_detective = true
  cryptographic_compute = true
}

# Custom tags
tags = {
  Project     = "terraform-ctf"
  Environment = "learning"
  Team        = "DevOps"
}
```

---

## 💻 Usage

### Using Make (Recommended)

```bash
# Initialize Terraform
make init

# Validate and format code
make validate

# Preview changes
make plan

# Apply challenges
make apply

# Clean up
make destroy

# Remove all Terraform files
make clean
```

### Using Terraform Directly

```bash
# Initialize
terraform init

# Format code
terraform fmt -recursive

# Validate configuration
terraform validate

# Preview
terraform plan

# Apply
terraform apply

# Destroy
terraform destroy
```

### Running Individual Challenges

```bash
# Challenge 1: Terraform Basics
terraform apply -target=module.challenges.ctfchallenge_flag_validator.terraform_basics

# Challenge 2: Expression Expert
terraform apply -target=module.challenges.ctfchallenge_flag_validator.expression_expert

# Challenge 8: Cryptographic Compute
terraform apply -target=module.challenges.ctfchallenge_flag_validator.cryptographic_compute
```

---

## 📊 Outputs

### Summary Output

```bash
terraform output summary
```

```json
{
  "player_name": "Alice",
  "total_possible": 2250,
  "total_earned": 2250,
  "challenges_completed": 8,
  "puzzle_solved": true
}
```

### Challenge Results

```bash
terraform output challenge_results
```

```json
{
  "terraform_basics": {
    "validated": true,
    "points": 100,
    "message": "🎉 Congratulations! You solved 'Terraform Basics'..."
  },
  "expression_expert": {
    "validated": true,
    "points": 350,
    "message": "🎉 Congratulations! You solved 'Expression Expert'..."
  }
  // ... more challenges
}
```

### Completion Percentage

```bash
terraform output completion_percentage
```

```
100.0%
```

### Secret Flags

```bash
terraform output -raw secret_flags
```

```json
{
  "xor_puzzle": "flag{xor_puzzl3_s0lv3d}"
}
```

### Detailed Challenge Info

```bash
# Expression computation steps
terraform output expression_computation_steps

# State secrets information
terraform output state_secrets_info

# Module master outputs
terraform output module_master_info

# Cryptographic computation details
terraform output cryptographic_compute_info
```

---

## 🏗️ Best Practices

This project demonstrates numerous Terraform best practices:

### 1. **Modular Architecture**
```
✓ Reusable modules
✓ Clear module boundaries
✓ Explicit inputs/outputs
✓ Module composition
```

### 2. **Code Organization**
```
✓ Separation of concerns
✓ Logical file structure
✓ Consistent naming conventions
✓ Grouped related resources
```

### 3. **Variable Management**
```
✓ Input validation
✓ Sensible defaults
✓ Type constraints
✓ Description documentation
```

### 4. **State Management**
```
✓ Proper resource dependencies
✓ Lifecycle management
✓ Conditional resource creation
✓ Count and for_each usage
```

### 5. **Security**
```
✓ Sensitive output protection
✓ No hardcoded secrets
✓ .gitignore configuration
✓ Provider version pinning
```

### 6. **Documentation**
```
✓ Inline comments
✓ Comprehensive README
✓ Module documentation
✓ Example usage
```

### 7. **DRY Principle**
```
✓ Shared locals
✓ Reusable variables
✓ Module reuse
✓ Function composition
```

### 8. **Version Control**
```
✓ Git integration
✓ Meaningful commits
✓ .gitignore configuration
✓ Branch strategy
```

---

## 🐛 Troubleshooting

### Common Issues

#### 1. Provider Not Found

**Error**:
```
Error: Failed to query available provider packages
```

**Solution**:
```bash
# Clear Terraform cache
rm -rf .terraform .terraform.lock.hcl

# Re-initialize
terraform init
```

#### 2. Variable Validation Failed

**Error**:
```
Error: Invalid value for variable
```

**Solution**:
Check `terraform.tfvars` for:
- Player name is not empty
- Hint levels are 0-2
- Tags are properly formatted

#### 3. Module Not Found

**Error**:
```
Error: Module not installed
```

**Solution**:
```bash
# Initialize modules
terraform init

# Update modules
terraform get -update
```

#### 4. State Lock Error

**Error**:
```
Error: Error acquiring the state lock
```

**Solution**:
```bash
# Force unlock (use carefully!)
terraform force-unlock <LOCK_ID>
```

#### 5. Challenge Not Validating

**Symptoms**: Challenge shows as completed but no points awarded

**Solution**:
1. Check the proof_of_work values are correct
2. Verify the flag matches exactly
3. Review Terraform output for error messages
4. Check challenge-specific requirements

---

## 📈 Progress Tracking

### View Your Progress

```bash
# Quick summary
terraform output summary

# Detailed breakdown
terraform output challenge_results | jq

# Completion percentage
terraform output completion_percentage
```

### Export Results

```bash
# Export to JSON
terraform output -json > ctf_results.json

# Export summary
terraform output summary > my_score.txt
```

---

## 🧪 Testing

### Validate Configuration

```bash
# Format check
terraform fmt -check -recursive

# Validation
terraform validate

# Plan (no apply)
terraform plan
```

### Dry Run

```bash
# Preview without applying
terraform plan -out=tfplan

# Review the plan
terraform show tfplan
```

---

## 🔄 Resetting Challenges

### Reset All

```bash
# Destroy all resources
terraform destroy

# Clean state
rm -f terraform.tfstate*

# Re-initialize
terraform init

# Start fresh
terraform apply
```

### Reset Single Challenge

```bash
# Destroy specific challenge
terraform destroy -target=module.challenges.ctfchallenge_flag_validator.terraform_basics

# Re-apply
terraform apply -target=module.challenges.ctfchallenge_flag_validator.terraform_basics
```

---

## 📚 Additional Resources

### Learning Terraform

- [Official Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
- [HashiCorp Learn](https://learn.hashicorp.com/terraform)

### Terraform Functions

- [Built-in Functions](https://www.terraform.io/language/functions)
- [Expression Reference](https://www.terraform.io/language/expressions)

### Community

- [Terraform Community Forum](https://discuss.hashicorp.com/c/terraform-core)
- [Terraform Registry](https://registry.terraform.io/)

---

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) first.

### How to Contribute

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Areas for Contribution

- 📝 Documentation improvements
- 🐛 Bug fixes
- ✨ New challenge ideas
- 🎨 Code refactoring
- 🧪 Additional tests
- 🌐 Translations

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Osama Ghozlan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction...
```

---

## 👤 Author

**Osama Ghozlan**

- GitHub: [@OMGhozlan](https://github.com/OMGhozlan)
- Provider: [terraform-provider-ctfchallenge](https://registry.terraform.io/providers/OMGhozlan/ctfchallenge)

---

## 🙏 Acknowledgments

- HashiCorp for creating Terraform
- The Terraform community for best practices and inspiration
- CTF challenge designers for the educational concept
- All contributors to this project

---

## 📞 Support

### Getting Help

- 📖 **Documentation**: Start with this README
- 💬 **Discussions**: Use GitHub Discussions for questions
- 🐛 **Issues**: Report bugs via GitHub Issues

### FAQ

**Q: Can I use this for learning Terraform?**  
A: Absolutely! This project is designed for educational purposes.

**Q: Do I need cloud credentials?**  
A: No, this project uses local providers and doesn't require cloud access.

**Q: Can I modify the challenges?**  
A: Yes! Fork the repository and customize as needed.

**Q: How long does it take to complete all challenges?**  
A: Typically 2-4 hours for beginners, 1-2 hours for experienced users.

**Q: Is there a leaderboard?**  
A: The provider supports score tracking if configured with an API endpoint.

---

## 🎯 Next Steps

Ready to begin? Follow these steps:

1. ✅ Clone the repository
2. ✅ Configure `terraform.tfvars`
3. ✅ Run `terraform init`
4. ✅ Start with Challenge 1: Terraform Basics
5. ✅ Progress through all challenges
6. ✅ Solve the bonus XOR puzzle
7. ✅ Achieve 100% completion!

**Good luck, and happy Terraforming! 🚀**

---

<div align="center">

### ⭐ If you found this helpful, please star the repository! ⭐

Made with ❤️ and Terraform

</div>
