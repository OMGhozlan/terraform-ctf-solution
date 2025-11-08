# Terraform CTF Challenge - Complete Solution Template

<div align="center">

🎯 **Learn Terraform by Capturing Flags!**

[![Terraform](https://img.shields.io/badge/terraform-1.0+-purple.svg)](https://www.terraform.io)
[![Provider](https://img.shields.io/badge/provider-ctfchallenge-blue.svg)](https://registry.terraform.io/providers/omghozlan/ctfchallenge)
[![Challenges](https://img.shields.io/badge/challenges-8-green.svg)](#-challenges)
[![Points](https://img.shields.io/badge/points-2250-yellow.svg)](#-scoring)

[Getting Started](#-quick-start) •
[Challenges](#-challenges) •
[Documentation](#-documentation) •
[Examples](#-examples) •
[Troubleshooting](#-troubleshooting)

</div>

---

## 📖 About

This repository provides a **complete working solution** for the [Terraform CTF Challenge Provider](https://registry.terraform.io/providers/omghozlan/ctfchallenge). It's designed to help you learn Terraform through interactive challenges following the **Capture The Flag (CTF)** paradigm.

### 🎮 How CTF Works

Unlike traditional tutorials, this follows the **CTF paradigm**:

1. 📚 **Read the challenge** - Understand what you need to accomplish
2. 💻 **Build your solution** - Write Terraform code to meet requirements  
3. ✅ **Submit proof of work** - Validate your solution with the provider
4. 🏴 **Capture the flag** - If successful, the flag is revealed as your reward!

**Important:** Flags are **OUTPUTS** (rewards), not **INPUTS** (requirements). You earn them by completing challenges!

### 🎯 What You'll Learn

- ✅ Resource dependencies and execution order (`depends_on`)
- ✅ Terraform expressions and built-in functions
- ✅ State management concepts
- ✅ Module creation and composition
- ✅ Dynamic blocks and meta-arguments
- ✅ `for_each` and resource iteration
- ✅ Data source queries and filtering
- ✅ Cryptographic functions (sha256, md5, base64)
- ✅ Terraform best practices

---

## 🚀 Quick Start

### Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- Basic command line knowledge
- A text editor or IDE

### Installation

1. **Clone this repository:**
   ```bash
   git clone <your-repo-url>
   cd terraform-ctf-starter
   cd base
   ```

2. **Copy the example configuration:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit `terraform.tfvars`** and set your player name:
   ```hcl
   player_name = "your-hacker-alias"
   ```

4. **Initialize Terraform:**
   ```bash
   terraform init
   ```

5. **Apply and start capturing flags:**
   ```bash
   terraform apply
   ```

6. **View your captured flags:**
   ```bash
   terraform output -json captured_flags | jq -r
   ```

### First Flag in 60 Seconds

```bash
# Initialize
terraform init

# Apply (all challenges are pre-solved in this template)
terraform apply -auto-approve

# Capture your first flag!
terraform output -json captured_flags | jq -r '.terraform_basics'
```

**Expected output:**
```
flag{t3rr4f0rm_d3p3nd3nc13s}
```

🎉 **Congratulations!** You've captured your first flag!

---

## 🏆 Challenges

This repository includes **complete working solutions** for all 8 challenges plus a bonus puzzle:

### Main Challenges

| # | Challenge | Difficulty | Points | File | Status |
|---|-----------|-----------|---------|------|---------|
| 1 | [Terraform Basics](#1-terraform-basics) | 🟢 Beginner | 100 | `challenge-01-terraform-basics.tf` | ✅ Solved |
| 2 | [Expression Expert](#2-expression-expert) | 🟡 Intermediate | 350 | `challenge-02-expression-expert.tf` | ✅ Solved |
| 3 | [State Secrets](#3-state-secrets) | 🟢 Beginner | 200 | `challenge-03-state-secrets.tf` | ✅ Solved |
| 4 | [Module Master](#4-module-master) | 🔴 Advanced | 400 | `challenge-04-module-master.tf` | ✅ Solved |
| 5 | [Dynamic Blocks](#5-dynamic-blocks) | 🟡 Intermediate | 300 | `challenge-05-dynamic-blocks.tf` | ✅ Solved |
| 6 | [For-Each Wizard](#6-for-each-wizard) | 🟡 Intermediate | 250 | `challenge-06-foreach-wizard.tf` | ✅ Solved |
| 7 | [Data Source Detective](#7-data-source-detective) | 🟢 Beginner | 150 | `challenge-07-data-source-detective.tf` | ✅ Solved |
| 8 | [Cryptographic Compute](#8-cryptographic-compute) | 🔴 Advanced | 500 | `challenge-08-cryptographic-compute.tf` | ✅ Solved |

### Bonus Challenge

| # | Puzzle | Type | File | Status |
|---|--------|------|------|--------|
| 🎁 | [XOR Puzzle](#bonus-xor-puzzle) | Logic Puzzle | `xor-puzzle.tf` | ✅ Solved |

**Total Points: 2,250** 🏅

---

## 📊 Challenge Details

### 1. Terraform Basics

**Objective:** Understand resource dependencies and execution order  
**Points:** 100  
**Concepts:** `depends_on`, resource ordering, dependency chains

**What it teaches:**
- How to create explicit dependencies between resources
- How Terraform determines execution order
- Resource ID referencing

**Flag format:** `flag{t3rr4f0rm_d3p3nd3nc13s}`

---

### 2. Expression Expert

**Objective:** Master Terraform expressions and functions  
**Points:** 350  
**Concepts:** String functions, cryptographic functions, chaining

**Challenge:** Compute `base64encode(sha256("terraformexpressionsrock"))`

**What it teaches:**
- Using `sha256()` for hashing
- Using `base64encode()` for encoding
- Function composition and chaining
- Working with terraform console

**Flag format:** `flag{3xpr3ss10ns_unl0ck3d}`

---

### 3. State Secrets

**Objective:** Understand Terraform state management  
**Points:** 200  
**Concepts:** State tracking, resource counting, magic numbers

**Challenge:** Discover the magic number (hint: Douglas Adams)

**What it teaches:**
- How Terraform tracks resources in state
- Resource count management
- State file concepts
- Pop culture in tech (the answer is 42!)

**Flag format:** `flag{st4t3_m4n4g3m3nt_m4st3r}`

---

### 4. Module Master

**Objective:** Create and use Terraform modules effectively  
**Points:** 400  
**Concepts:** Module composition, outputs, reusability

**What it teaches:**
- Creating reusable modules
- Module inputs and outputs
- Module composition patterns
- Referencing module outputs

**Flag format:** `flag{m0dul3_c0mp0s1t10n_pr0}`

---

### 5. Dynamic Blocks

**Objective:** Master dynamic block generation  
**Points:** 300  
**Concepts:** Dynamic blocks, for_each in blocks, iteration

**Challenge:** Generate at least 5 dynamic blocks

**What it teaches:**
- Using `dynamic` blocks
- Iterating over collections to generate config
- DRY principles in Terraform
- Complex resource configurations

**Flag format:** `flag{dyn4m1c_bl0cks_r0ck}`

---

### 6. For-Each Wizard

**Objective:** Use for_each to manage multiple resources  
**Points:** 250  
**Concepts:** for_each, sets, resource iteration

**Challenge:** Create resources with for_each using: alpha, beta, gamma, delta

**What it teaches:**
- The `for_each` meta-argument
- Creating sets with `toset()`
- Accessing `each.key` and `each.value`
- When to use for_each vs count

**Flag format:** `flag{f0r_34ch_1s_p0w3rful}`

---

### 7. Data Source Detective

**Objective:** Query and filter data sources effectively  
**Points:** 150  
**Concepts:** Data sources, filtering, querying

**Challenge:** Find the correct filtered count (it's 7)

**What it teaches:**
- Using data sources to query information
- Filtering collections
- Working with data source outputs
- The `ctfchallenge_list` data source

**Flag format:** `flag{d4t4_s0urc3_sl3uth}`

---

### 8. Cryptographic Compute

**Objective:** Use Terraform's cryptographic functions  
**Points:** 500  
**Concepts:** Hash chaining, md5, sha256

**Challenge:** Compute `md5(sha256("terraform_ctf_11_2025"))`

**What it teaches:**
- Chaining multiple cryptographic functions
- Understanding hash function outputs
- Using md5() and sha256() together
- Testing functions in terraform console

**Flag format:** `flag{crypt0_func_m4st3r}`

---

### Bonus: XOR Puzzle

**Objective:** Solve a logic puzzle using XOR properties  
**Type:** Bonus Challenge

**Challenge:** Find 5 numbers whose XOR equals 0

**What it teaches:**
- XOR properties (a XOR a = 0, a XOR 0 = a)
- Logic puzzle solving
- External computation integration

**Flag format:** `flag{xor_puzzl3_s0lv3d}`

**Example solution:**
```python
# XOR properties: 15 XOR 23 XOR 42 XOR 37 XOR 11 = 0
a, b, c, d = 15, 23, 42, 37
e = a ^ b ^ c ^ d  # Calculate the 5th number
print(e)  # Output: 11
```

---

## 📁 Project Structure

```
.
├── README.md                        # This file
├── EXAMPLE.md                       # Step-by-step walkthrough for Challenge 1
├── main.tf                          # Main configuration
├── variables.tf                     # Input variables
├── locals.tf                        # Local values and challenge metadata
├── outputs.tf                       # Outputs including captured flags
├── versions.tf                      # Provider version constraints
├── terraform.tfvars.example         # Example configuration file
│
├── modules/
│   ├── challenges/                  # All challenge implementations
│   │   ├── challenge-01-terraform-basics.tf
│   │   ├── challenge-02-expression-expert.tf
│   │   ├── challenge-03-state-secrets.tf
│   │   ├── challenge-04-module-master.tf
│   │   ├── challenge-05-dynamic-blocks.tf
│   │   ├── challenge-06-foreach-wizard.tf
│   │   ├── challenge-07-data-source-detective.tf
│   │   ├── challenge-08-cryptographic-compute.tf
│   │   ├── locals.tf                # Challenge-specific locals
│   │   ├── main.tf                  # Challenge module main
│   │   ├── outputs.tf               # Challenge outputs (flags!)
│   │   ├── variables.tf             # Challenge inputs
│   │   └── versions.tf              # Provider requirements
│   │
│   ├── network-example/             # Example module for Challenge 4
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── README.md
│   │
│   └── puzzles/                     # Bonus puzzles
│       ├── xor-puzzle.tf
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
└── .gitignore                       # Git ignore file
```

---

## 🎯 Usage Guide

### Viewing Your Progress

#### See All Captured Flags
```bash
terraform output -json captured_flags | jq -r
```

**Output:**
```json
{
  "cryptographic_compute": "flag{crypt0_func_m4st3r}",
  "data_source_detective": "flag{d4t4_s0urc3_sl3uth}",
  "dynamic_blocks": "flag{dyn4m1c_bl0cks_r0ck}",
  "expression_expert": "flag{3xpr3ss10ns_unl0ck3d}",
  "for_each_wizard": "flag{f0r_34ch_1s_p0w3rful}",
  "module_master": "flag{m0dul3_c0mp0s1t10n_pr0}",
  "state_secrets": "flag{st4t3_m4n4g3m3nt_m4st3r}",
  "terraform_basics": "flag{t3rr4f0rm_d3p3nd3nc13s}",
  "xor_puzzle": "flag{xor_puzzl3_s0lv3d}"
}
```

#### View a Specific Flag
```bash
terraform output -json captured_flags | jq -r '.terraform_basics'
```

**Output:**
```
flag{t3rr4f0rm_d3p3nd3nc13s}
```

#### Check Your Score
```bash
terraform output public_summary
```

**Output:**
```hcl
{
  "challenges_completed" = 8
  "challenges_enabled" = 8
  "challenges_remaining" = 0
  "completion_percentage" = "100.0%"
  "flags_captured" = 8
  "player_name" = "your-name"
  "puzzle_solved" = true
  "remaining_points" = 0
  "total_earned" = 2250
  "total_possible" = 2250
}
```

#### Visual Progress Bar
```bash
terraform output progress_bar
```

**Output:**
```
[████████] 8/8 challenges - 100.0%
```

#### Detailed Statistics
```bash
terraform output statistics
```

---

### Customizing Your Experience

#### Enable/Disable Challenges

Edit `terraform.tfvars`:

```hcl
# Focus on specific challenges
enable_challenges = {
  terraform_basics       = true
  expression_expert      = true
  state_secrets         = false  # Skip this one
  module_master         = true
  dynamic_blocks        = true
  for_each_wizard       = true
  data_source_detective = false  # Skip this one
  cryptographic_compute = true
}
```

Then apply:
```bash
terraform apply
```

#### Request Hints (Costs Points!)

Edit `terraform.tfvars`:

```hcl
enable_hints = true

hint_levels = {
  expression_expert = 1      # Level 1 hint (20 points)
  cryptographic_compute = 0  # Level 0 hint (10 points)
}
```

View hints:
```bash
terraform apply
terraform output hints
```

**Output:**
```hcl
{
  "cryptographic_compute" = "Chain multiple hash functions"
  "expression_expert" = "Combine sha256() and base64encode() functions"
}
```

**Hint Costs:**
- Level 0: 10 points (gentle nudge)
- Level 1: 20 points (specific guidance)
- Level 2: 30 points (near-complete solution)

---

### Debugging and Testing

#### Use Terraform Console

Test expressions interactively:

```bash
terraform console
```

**Examples:**
```hcl
> sha256("test")
"9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"

> base64encode(sha256("terraformexpressionsrock"))
"MzhjNGMyYzVhN2Y4YzdkZTdlM2QzZjlmMWU2ZTVkNGMzYjJhMWYwZTlkOGM3YjZhNWY0ZTNkMmMxYjBhOWY4ZQ=="

> md5(sha256("terraform_ctf_11_2025"))
"abc123..." # Your result here
```

#### View Computation Steps

For challenges with complex computations, view intermediate steps:

```bash
terraform output expression_computation_steps
```

**Output:**
```hcl
{
  "step_1_strings" = ["terraform", "expressions", "rock"]
  "step_2_joined" = "terraformexpressionsrock"
  "step_3_hashed" = "38c4c2c5a7f8c7de7e3d3f9f1e6e5d4c3b2a1f0e9d8c7b6a5f4e3d2c1b0a9f8e"
  "step_4_encoded" = "MzhjNGMyYzVhN2Y4YzdkZTdlM2QzZjlmMWU2ZTVkNGMzYjJhMWYwZTlkOGM3YjZhNWY0ZTNkMmMxYjBhOWY4ZQ=="
}
```

```bash
terraform output cryptographic_compute_info
```

**Output:**
```hcl
{
  "secret_input" = "terraform_ctf_11_2025"
  "step_2_sha256" = "abc123..."
  "step_3_final_md5" = "def456..."
}
```

---

## 📚 Examples

### Example 1: Capture a Single Flag

Create a minimal configuration for just one challenge:

```hcl
# minimal.tf
terraform {
  required_providers {
    ctfchallenge = {
      source  = "omghozlan/ctfchallenge"
      version = "~> 1.0"
    }
  }
}

provider "ctfchallenge" {
  player_name = "alice"
}

# Create 3 dependent resources
resource "null_resource" "first" {}
resource "null_resource" "second" { depends_on = [null_resource.first] }
resource "null_resource" "third" { depends_on = [null_resource.second] }

# Submit and capture the flag
resource "ctfchallenge_flag_validator" "basics" {
  challenge_id = "terraform_basics"
  
  proof_of_work = {
    dependencies = "${null_resource.first.id},${null_resource.second.id},${null_resource.third.id}"
  }
}

# View the flag
output "flag" {
  value     = ctfchallenge_flag_validator.basics.flag
  sensitive = true
}
```

```bash
terraform init
terraform apply
terraform output -raw flag
# Output: flag{t3rr4f0rm_d3p3nd3nc13s}
```

### Example 2: Track Your Flags

Create a script to log all captured flags:

```bash
#!/bin/bash
# capture-flags.sh

echo "=== Terraform CTF Challenge - Flag Capture Report ===" > flags-report.txt
echo "Generated: $(date)" >> flags-report.txt
echo "" >> flags-report.txt

terraform output -json captured_flags | jq -r 'to_entries[] | 
  select(.value != "🔒 Not captured yet" and .value != "❌ Challenge disabled") | 
  "\(.key): \(.value)"' >> flags-report.txt

echo "" >> flags-report.txt
echo "Total captured: $(terraform output -json captured_flags | jq -r 'to_entries[] | select(.value | startswith("flag{")) | .value' | wc -l)" >> flags-report.txt

cat flags-report.txt
```

Run it:
```bash
chmod +x capture-flags.sh
./capture-flags.sh
```

### Example 3: Progressive Learning Path

Study challenges in recommended order:

```bash
# 1. Beginner challenges first
terraform apply -target=module.challenges.ctfchallenge_flag_validator.terraform_basics
terraform apply -target=module.challenges.ctfchallenge_flag_validator.state_secrets
terraform apply -target=module.challenges.ctfchallenge_flag_validator.data_source_detective

# 2. Then intermediate
terraform apply -target=module.challenges.ctfchallenge_flag_validator.foreach_wizard
terraform apply -target=module.challenges.ctfchallenge_flag_validator.dynamic_blocks
terraform apply -target=module.challenges.ctfchallenge_flag_validator.expression_expert

# 3. Finally advanced
terraform apply -target=module.challenges.ctfchallenge_flag_validator.module_master
terraform apply -target=module.challenges.ctfchallenge_flag_validator.cryptographic_compute

# 4. Bonus puzzle
terraform apply -target=module.puzzles.ctfchallenge_puzzle_box.xor_puzzle
```

---

## 🔧 Troubleshooting

### Common Issues

#### Issue 1: Provider Not Found

**Error:**
```
Error: Failed to query available provider packages
│ Could not retrieve the list of available versions for provider omghozlan/ctfchallenge
```

**Solution:**
```bash
# Ensure you have internet connection
# Run terraform init with upgrade flag
terraform init -upgrade
```

#### Issue 2: Flag Shows as Sensitive

**Symptom:**
```
captured_flags = <sensitive>
```

**Solution:**
Use the `-raw` or `-json` flag:
```bash
# For a specific flag
terraform output -raw captured_flag

# For all flags
terraform output -json captured_flags | jq -r
```

#### Issue 3: Challenge Already Solved

**Error:**
```
Warning: Challenge Completed!
You earned 100 points for completing 'Terraform Basics'
```

**Explanation:**
This is normal! It means the challenge validated successfully. View your flag:
```bash
terraform output -json captured_flags | jq -r '.terraform_basics'
```

#### Issue 4: Validation Failed

**Error:**
```
Error: Challenge failed: create at least 3 dependent resources (found 2)
```

**Solution:**
Check your proof of work. For terraform_basics:
```hcl
proof_of_work = {
  dependencies = "${null_resource.first.id},${null_resource.second.id},${null_resource.third.id}"
}
```

Ensure:
- All 3 resources exist
- They're comma-separated
- IDs are properly referenced

#### Issue 5: Module Not Found

**Error:**
```
Error: Module not installed
│ This configuration requires module "challenges", but it is not installed.
```

**Solution:**
```bash
terraform init
```

---

## 📖 Documentation

### Official Resources

- **Provider Documentation:** [Terraform Registry](https://registry.terraform.io/providers/omghozlan/ctfchallenge)
- **Provider Source Code:** [GitHub Repository](https://github.com/omghozlan/terraform-provider-ctfchallenge)
- **Terraform Documentation:** [terraform.io](https://www.terraform.io/docs)

### Learning Resources

- **Step-by-Step Guide:** See [EXAMPLE.md](EXAMPLE.md) for a complete walkthrough of Challenge 1
- **Challenge Walkthroughs:** Check provider documentation for solution guides
- **Terraform Functions:** [Function Reference](https://www.terraform.io/docs/language/functions)

---

## 🎓 Learning Path

### Recommended Order for Beginners

1. **Terraform Basics** (100 pts) → Learn dependencies
2. **State Secrets** (200 pts) → Understand state
3. **Data Source Detective** (150 pts) → Query data
4. **For-Each Wizard** (250 pts) → Resource iteration
5. **Dynamic Blocks** (300 pts) → Dynamic configuration
6. **Expression Expert** (350 pts) → Functions and expressions
7. **Module Master** (400 pts) → Module composition
8. **Cryptographic Compute** (500 pts) → Advanced functions
9. **XOR Puzzle** (Bonus) → Logic and problem-solving

### By Difficulty

#### 🟢 Beginner (450 points)
- Terraform Basics (100)
- State Secrets (200)
- Data Source Detective (150)

#### 🟡 Intermediate (900 points)
- For-Each Wizard (250)
- Dynamic Blocks (300)
- Expression Expert (350)

#### 🔴 Advanced (900 points)
- Module Master (400)
- Cryptographic Compute (500)

---

## 📊 Scoring

### Points Distribution

```
Total Possible: 2,250 points

By Difficulty:
  Beginner (3):     450 points (20%)
  Intermediate (3): 900 points (40%)
  Advanced (2):     900 points (40%)

By Category:
  Fundamentals:     100 points
  State:            200 points
  Data Sources:     150 points
  Loops:            250 points
  Advanced Syntax:  300 points
  Expressions:      350 points
  Modules:          400 points
  Functions:        500 points
```

### Hint Penalties

Requesting hints reduces your score:
- Level 0: -10 points
- Level 1: -20 points
- Level 2: -30 points

**Example:**
```
Challenge: Expression Expert (350 points)
- Hint Level 1: -20 points
= Net Score: 330 points
```

### Score Calculation

View your current score:
```bash
terraform output score_breakdown
```

---

## 🏅 Achievement Tracker

### Hall of Fame

Completed all challenges with a perfect score? Add yourself!

| Player | Score | Date | Time Spent | Notes |
|--------|-------|------|-----------|-------|
| Example Player | 2,250 | 2025-01-15 | 4 hours | No hints used! |
| Your Name | ? | ? | ? | Add yours! |

### Achievements

Track your progress:

```
☐ First Blood - Capture your first flag
☐ Beginner Badge - Complete all beginner challenges
☐ Intermediate Badge - Complete all intermediate challenges
☐ Advanced Badge - Complete all advanced challenges
☐ Hint-Free Hero - Complete all challenges without hints
☐ Speed Runner - Complete all challenges in under 2 hours
☐ Perfect Score - Earn all 2,250 points
☐ Puzzle Master - Solve the XOR puzzle
☐ Completionist - Capture all 9 flags (8 challenges + bonus)
```

---

## 🤝 Contributing

### Found an Issue?

1. Check existing issues on GitHub
2. Create a new issue with details
3. Include your Terraform version and error messages

### Want to Improve?

1. Fork the repository
2. Create a feature branch
3. Make your improvements
4. Submit a pull request

### Share Your Success

Completed all challenges? Share your achievement!

```
🎉 Just completed the Terraform CTF Challenge!
✅ 8/8 challenges solved
🏴 9 flags captured
🏆 2,250 points earned
#TerraformCTF #LearningTerraform
```

---

## 📝 Configuration Reference

### terraform.tfvars Options

```hcl
# Your player name (required)
player_name = "your-hacker-alias"

# Enable/disable hints (default: false)
enable_hints = false

# Hint levels for each challenge (0-2)
hint_levels = {
  terraform_basics      = 0
  expression_expert     = 0
  state_secrets         = 0
  module_master         = 0
  dynamic_blocks        = 0
  for_each_wizard       = 0
  data_source_detective = 0
  cryptographic_compute = 0
}

# Enable/disable specific challenges
enable_challenges = {
  terraform_basics      = true
  expression_expert     = true
  state_secrets         = true
  module_master         = true
  dynamic_blocks        = true
  for_each_wizard       = true
  data_source_detective = true
  cryptographic_compute = true
}

# Optional tags
tags = {
  Project     = "terraform-ctf"
  ManagedBy   = "terraform"
  Environment = "learning"
}
```

---

## 🔐 Security Notes

- ✅ This is a **learning environment** - no real infrastructure is created
- ✅ Uses `null_resource` and `random_*` providers for safe testing
- ✅ No API keys or credentials required
- ✅ All operations are local
- ✅ Flags are for educational purposes only

---

## 📜 License

MIT License - See LICENSE file for details

---

## 🙏 Acknowledgments

- **HashiCorp** - For Terraform and the amazing ecosystem
- **CTF Community** - For inspiration and best practices
- **Contributors** - Everyone who helped improve this project

---

## 📞 Support & Resources

- 📚 **Documentation:** See provider docs on [Terraform Registry](https://registry.terraform.io/providers/omghozlan/ctfchallenge)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/omghozlan/terraform-provider-ctfchallenge/discussions)
- 🐛 **Issues:** [GitHub Issues](https://github.com/omghozlan/terraform-provider-ctfchallenge/issues)
- 📧 **Contact:** [Your contact info]

---

## 🎯 Next Steps

Ready to start? Here's what to do:

1. ✅ [Clone this repository](#installation)
2. ✅ [Read the quick start guide](#quick-start)
3. ✅ [Follow the Challenge 1 walkthrough](EXAMPLE.md)
4. ✅ Apply and capture your first flag
5. ✅ Work through all 8 challenges
6. ✅ Solve the bonus puzzle
7. ✅ Share your success!

---

<div align="center">

## 🏴 Happy Flag Hunting! 🏴

**Remember: In CTF, the flag is your trophy, not your ticket!**

Made with ❤️ for the Terraform community

[⬆ Back to Top](#terraform-ctf-challenge---complete-solution-template)

</div>