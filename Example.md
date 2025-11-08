# Complete Walkthrough: Capturing Your First Flag

This guide walks you through solving **Challenge 1: Terraform Basics** step-by-step, from initial setup to capturing your first flag! 🏴

## 📋 Prerequisites

Before starting, ensure you have:
- ✅ Terraform installed (version 1.0+)
- ✅ Basic command line knowledge
- ✅ A text editor

Check your Terraform version:
```bash
terraform version
# Should output: Terraform v1.x.x or higher
```

## 🎯 Challenge Overview

**Challenge:** Terraform Basics  
**Difficulty:** Beginner  
**Points:** 100  
**Objective:** Understand resource dependencies and execution order  

**What you'll learn:**
- Creating Terraform resources
- Using `depends_on` to control execution order
- Submitting proof of work
- Capturing flags as rewards

---

## Step 1: Initial Setup

### 1.1 Create Your Workspace

```bash
# Create a new directory for your CTF challenge
mkdir terraform-ctf-my-first-flag
cd terraform-ctf-my-first-flag
```

### 1.2 Create Basic Configuration Files

Create a `versions.tf` file:

```hcl
# versions.tf
terraform {
  required_version = ">= 1.0"

  required_providers {
    ctfchallenge = {
      source  = "omghozlan/ctfchallenge"
      version = "~> 1.0"
    }
  }
}
```

Create a `main.tf` file:

```hcl
# main.tf
provider "ctfchallenge" {
  player_name = "your-name-here"  # Replace with your name!
}
```

### 1.3 Initialize Terraform

```bash
terraform init
```

**Expected Output:**
```
Initializing the backend...

Initializing provider plugins...
- Finding omghozlan/ctfchallenge versions matching "~> 1.0"...
- Installing omghozlan/ctfchallenge v1.0.x...
- Installed omghozlan/ctfchallenge v1.0.x

Terraform has been successfully initialized!
```

✅ **Checkpoint:** If you see "successfully initialized", you're ready to proceed!

---

## Step 2: Explore the Challenge

### 2.1 Get Challenge Information

Add this to your `main.tf`:

```hcl
# main.tf (continued)

# Get information about the Terraform Basics challenge
data "ctfchallenge_challenge_info" "basics" {
  challenge_id = "terraform_basics"
}

# Display challenge information
output "challenge_info" {
  value = {
    name        = data.ctfchallenge_challenge_info.basics.name
    description = data.ctfchallenge_challenge_info.basics.description
    points      = data.ctfchallenge_challenge_info.basics.points
    difficulty  = data.ctfchallenge_challenge_info.basics.difficulty
    category    = data.ctfchallenge_challenge_info.basics.category
  }
}
```

### 2.2 Apply to See Challenge Details

```bash
terraform apply -auto-approve
```

**Expected Output:**
```
Outputs:

challenge_info = {
  "category" = "fundamentals"
  "description" = "Understand resource dependencies and outputs"
  "difficulty" = "beginner"
  "name" = "Terraform Basics"
  "points" = 100
}
```

### 2.3 Understanding the Challenge

The challenge requires you to:
1. Create **at least 3 resources**
2. Establish **dependencies** between them
3. Submit the **resource IDs** as proof

💡 **Key Concept:** Terraform's `depends_on` allows you to explicitly define execution order.

---

## Step 3: Build Your Solution

### 3.1 Create Your First Resource

Add to `main.tf`:

```hcl
# main.tf (continued)

# Resource 1: The Foundation
resource "null_resource" "first" {
  triggers = {
    name      = "first-resource"
    timestamp = timestamp()
  }
}
```

**What this does:**
- Creates a `null_resource` (a placeholder resource perfect for learning)
- Uses `triggers` to force recreation on each apply
- This is your **first** resource in the dependency chain

### 3.2 Create a Dependent Resource

Add the second resource:

```hcl
# main.tf (continued)

# Resource 2: Depends on Resource 1
resource "null_resource" "second" {
  depends_on = [null_resource.first]  # 👈 This creates the dependency!
  
  triggers = {
    name      = "second-resource"
    timestamp = timestamp()
  }
}
```

**Key points:**
- `depends_on = [null_resource.first]` tells Terraform: "Create `first` before `second`"
- This creates an **explicit dependency**

### 3.3 Create the Third Resource

Add the third resource:

```hcl
# main.tf (continued)

# Resource 3: Depends on Resource 2
resource "null_resource" "third" {
  depends_on = [null_resource.second]  # 👈 Depends on second
  
  triggers = {
    name      = "third-resource"
    timestamp = timestamp()
  }
}
```

**Dependency Chain:**
```
first → second → third
```

Terraform will create them in this exact order!

### 3.4 Test Your Resources

Apply your configuration:

```bash
terraform apply
```

**Expected Output:**
```
Terraform will perform the following actions:

  # null_resource.first will be created
  + resource "null_resource" "first" {
      + id       = (known after apply)
      + triggers = {
          + "name"      = "first-resource"
          + "timestamp" = (known after apply)
        }
    }

  # null_resource.second will be created
  + resource "null_resource" "second" {
      + id       = (known after apply)
      + triggers = {
          + "name"      = "second-resource"
          + "timestamp" = (known after apply)
        }
    }

  # null_resource.third will be created
  + resource "null_resource" "third" {
      + id       = (known after apply)
      + triggers = {
          + "name"      = "third-resource"
          + "timestamp" = (known after apply)
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
```

Type `yes` and press Enter.

**After Apply:**
```
null_resource.first: Creating...
null_resource.first: Creation complete after 0s [id=1234567890]
null_resource.second: Creating...
null_resource.second: Creation complete after 0s [id=2345678901]
null_resource.third: Creating...
null_resource.third: Creation complete after 0s [id=3456789012]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

✅ **Checkpoint:** Notice the order? They were created exactly as we specified!

---

## Step 4: Submit Proof of Work and Capture the Flag

### 4.1 Add the Flag Validator

Now for the exciting part - submitting your solution! Add this to `main.tf`:

```hcl
# main.tf (continued)

# Submit your solution and capture the flag!
resource "ctfchallenge_flag_validator" "basics" {
  challenge_id = "terraform_basics"
  
  # Proof of work: provide the IDs of your 3 dependent resources
  proof_of_work = {
    dependencies = join(",", [
      null_resource.first.id,
      null_resource.second.id,
      null_resource.third.id,
    ])
  }
}
```

**What this does:**
- References your three resources
- Joins their IDs into a comma-separated string
- Submits them as proof that you completed the challenge

### 4.2 Add Outputs to View Results

Add outputs to see your results:

```hcl
# main.tf (continued)

# View validation results
output "validation_result" {
  value = {
    validated = ctfchallenge_flag_validator.basics.validated
    message   = ctfchallenge_flag_validator.basics.message
    points    = ctfchallenge_flag_validator.basics.points
  }
}

# 🏴 THE FLAG - Your reward!
output "captured_flag" {
  value     = ctfchallenge_flag_validator.basics.flag
  sensitive = true
}
```

### 4.3 Apply and Capture Your Flag

```bash
terraform apply
```

**Expected Output:**
```
Terraform will perform the following actions:

  # ctfchallenge_flag_validator.basics will be created
  + resource "ctfchallenge_flag_validator" "basics" {
      + challenge_id  = "terraform_basics"
      + flag          = (sensitive value)
      + id            = (known after apply)
      + message       = (known after apply)
      + points        = (known after apply)
      + timestamp     = (known after apply)
      + validated     = (known after apply)
      + proof_of_work = {
          + "dependencies" = "1234567890,2345678901,3456789012"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
```

Type `yes` and press Enter.

**Success Output:**
```
ctfchallenge_flag_validator.basics: Creating...

Warning: Challenge Completed!

You earned 100 points for completing 'Terraform Basics'

ctfchallenge_flag_validator.basics: Creation complete after 0s

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

validation_result = {
  "message" = "🎉 Congratulations! You solved 'Terraform Basics' and earned 100 points!"
  "points" = 100
  "validated" = true
}
```

🎉 **SUCCESS!** You've completed the challenge!

---

## Step 5: View Your Captured Flag

### 5.1 Display the Flag

The flag is marked as sensitive, so use this command:

```bash
terraform output -raw captured_flag
```

**Output:**
```
flag{t3rr4f0rm_d3p3nd3nc13s}
```

🏴 **CONGRATULATIONS!** You've captured your first flag!

### 5.2 Understanding the Flag

- **Format:** `flag{...}` - Standard CTF flag format
- **Content:** `t3rr4f0rm_d3p3nd3nc13s` - Leetspeak for "terraform dependencies"
- **Significance:** Proof that you completed the challenge!

### 5.3 Save Your Flag

Create a flags log:

```bash
echo "Challenge 1 - Terraform Basics: $(terraform output -raw captured_flag)" >> flags.txt
cat flags.txt
```

**Output:**
```
Challenge 1 - Terraform Basics: flag{t3rr4f0rm_d3p3nd3nc13s}
```

---

## 📝 Complete Working Example

Here's the complete `main.tf` file for reference:

```hcl
# main.tf - Complete Solution for Challenge 1

terraform {
  required_version = ">= 1.0"

  required_providers {
    ctfchallenge = {
      source  = "omghozlan/ctfchallenge"
      version = "~> 1.0"
    }
  }
}

provider "ctfchallenge" {
  player_name = "your-name-here"
}

# ============================================================================
# Get Challenge Information
# ============================================================================

data "ctfchallenge_challenge_info" "basics" {
  challenge_id = "terraform_basics"
}

output "challenge_info" {
  value = {
    name        = data.ctfchallenge_challenge_info.basics.name
    description = data.ctfchallenge_challenge_info.basics.description
    points      = data.ctfchallenge_challenge_info.basics.points
    difficulty  = data.ctfchallenge_challenge_info.basics.difficulty
  }
}

# ============================================================================
# Solution: Create 3 Dependent Resources
# ============================================================================

resource "null_resource" "first" {
  triggers = {
    name      = "first-resource"
    timestamp = timestamp()
  }
}

resource "null_resource" "second" {
  depends_on = [null_resource.first]
  
  triggers = {
    name      = "second-resource"
    timestamp = timestamp()
  }
}

resource "null_resource" "third" {
  depends_on = [null_resource.second]
  
  triggers = {
    name      = "third-resource"
    timestamp = timestamp()
  }
}

# ============================================================================
# Submit Proof of Work and Capture the Flag
# ============================================================================

resource "ctfchallenge_flag_validator" "basics" {
  challenge_id = "terraform_basics"
  
  proof_of_work = {
    dependencies = join(",", [
      null_resource.first.id,
      null_resource.second.id,
      null_resource.third.id,
    ])
  }
}

# ============================================================================
# Outputs
# ============================================================================

output "validation_result" {
  value = {
    validated = ctfchallenge_flag_validator.basics.validated
    message   = ctfchallenge_flag_validator.basics.message
    points    = ctfchallenge_flag_validator.basics.points
    timestamp = ctfchallenge_flag_validator.basics.timestamp
  }
}

output "captured_flag" {
  description = "🏴 Your captured flag!"
  value       = ctfchallenge_flag_validator.basics.flag
  sensitive   = true
}

output "proof_submitted" {
  description = "The proof of work you submitted"
  value = {
    first_id  = null_resource.first.id
    second_id = null_resource.second.id
    third_id  = null_resource.third.id
    combined  = join(",", [
      null_resource.first.id,
      null_resource.second.id,
      null_resource.third.id,
    ])
  }
}
```

---

## 🔍 Troubleshooting

### Problem 1: "Unknown challenge: terraform_basics"

**Error:**
```
Error: Unknown challenge: terraform_basics
```

**Solution:**
- Ensure you're using the correct provider version
- Run `terraform init -upgrade`

### Problem 2: "Challenge failed: create at least 3 dependent resources"

**Error:**
```
Error: Challenge failed: create at least 3 dependent resources (found 2)
```

**Solution:**
- Check that you have exactly 3 resources
- Ensure the IDs are properly joined with commas
- Verify all resources are created before the validator

### Problem 3: Flag output shows "(sensitive value)"

**Symptom:**
```
captured_flag = <sensitive>
```

**Solution:**
Use the `-raw` flag:
```bash
terraform output -raw captured_flag
```

---

## 🎓 What You Learned

By completing this challenge, you now understand:

✅ **Terraform Resource Creation**
- How to define resources
- Using `null_resource` for testing

✅ **Dependency Management**
- Explicit dependencies with `depends_on`
- How Terraform orders resource creation

✅ **Terraform Functions**
- `join()` to combine lists into strings
- Referencing resource attributes

✅ **CTF Paradigm**
- Completing challenges reveals flags (they're not inputs!)
- Proof of work validates your solution
- Flags are your reward for completion

✅ **Terraform Workflow**
- `terraform init` - Initialize providers
- `terraform apply` - Create resources
- `terraform output` - View results

---

## 🚀 Next Steps

Now that you've captured your first flag, try these:

### Challenge 2: Expression Expert (350 points)
Learn Terraform's expression syntax and functions by computing:
```hcl
base64encode(sha256("terraformexpressionsrock"))
```

### Challenge 3: State Secrets (200 points)
Discover the "magic number" (hint: Douglas Adams).

### Challenge 7: Data Source Detective (150 points)
Master data source filtering.

---

## 📊 Your Progress

```
[█░░░░░░░] 1/8 challenges - 12.5%
Points: 100/2,250

Captured Flags:
✅ flag{t3rr4f0rm_d3p3nd3nc13s}
```

---

## 💡 Pro Tips

1. **Use terraform console** to test expressions:
   ```bash
   terraform console
   > null_resource.first.id
   ```

2. **Save your progress** with version control:
   ```bash
   git init
   git add main.tf
   git commit -m "Solved Challenge 1: Terraform Basics"
   ```

3. **Document your flags**:
   ```bash
   echo "$(date): Captured flag{t3rr4f0rm_d3p3nd3nc13s}" >> journey.log
   ```

4. **Share your success** (without spoiling the solution):
   ```
   🎉 Just captured my first flag in the Terraform CTF Challenge!
   Challenge: Terraform Basics ✅
   Points: 100
   #TerraformCTF #LearningTerraform
   ```

---

## 🎉 Congratulations!

You've successfully:
- ✅ Set up the Terraform CTF environment
- ✅ Understood challenge requirements
- ✅ Built a working solution
- ✅ Submitted proof of work
- ✅ **Captured your first flag!**

**You're now a Terraform CTF player!** 🏴‍☠️

Ready for the next challenge? The full solution template includes all 8 challenges. Good luck, and happy flag hunting!

---

**Remember:** In CTF, the flag is your trophy, not your ticket! 🏆