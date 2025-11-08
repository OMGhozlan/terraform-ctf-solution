# Step-by-Step Guide: Solving Your First Challenge

## Challenge 1: Terraform Basics (100 points)

This is the simplest challenge - perfect for beginners!

---

## 📋 Prerequisites

Before starting, ensure you have:
- ✅ Terraform installed
- ✅ The CTF provider installed
- ✅ Your `terraform.tfvars` configured

---

## 🎯 Understanding the Challenge

### What You Need to Do:
Create **at least 3 resources** with **explicit dependencies** using `depends_on`.

### What You'll Learn:
- How Terraform manages resource dependencies
- How to control execution order
- How `depends_on` works

### The Flag:
```
flag{t3rr4f0rm_d3p3nd3nc13s}
```

### Proof of Work:
You need to provide a comma-separated list of resource IDs showing your dependency chain.

---

## 🚀 Step-by-Step Solution

### Step 1: Set Up Your Environment

**Navigate to your project directory:**
```bash
cd terraform-ctf-starter  # or your project directory
```

**Verify Terraform is installed:**
```bash
terraform version
```

**Create your `terraform.tfvars` file** (if you haven't already):
```bash
cp terraform.tfvars.example terraform.tfvars
```

**Edit `terraform.tfvars`:**
```hcl
player_name = "YourName"  # Replace with your actual name

enable_challenges = {
  terraform_basics      = true   # Make sure this is enabled
  expression_expert     = false  # Disable others for now
  state_secrets         = false
  module_master         = false
  dynamic_blocks        = false
  for_each_wizard       = false
  data_source_detective = false
  cryptographic_compute = false
}
```

---

### Step 2: Create Your Solution File

**Create or edit:** `solutions/challenge-01-terraform-basics.tf`

Here's the complete solution with detailed comments:

```hcl
# ============================================================================
# Challenge 1: Terraform Basics - SOLUTION
# ============================================================================

# ----------------------------------------------------------------------------
# Step 1: Create the FIRST resource in the dependency chain
# ----------------------------------------------------------------------------
# This resource has NO dependencies - it will be created first
resource "null_resource" "step_1_foundation" {
  # The triggers block forces Terraform to track changes
  triggers = {
    timestamp = timestamp()  # Current timestamp
    step      = "foundation" # A label for this step
    order     = 1           # This is step 1
  }

  # Optional: This command runs when the resource is created
  provisioner "local-exec" {
    command = "echo 'Step 1: Foundation laid'"
  }
}

# ----------------------------------------------------------------------------
# Step 2: Create the SECOND resource that depends on the first
# ----------------------------------------------------------------------------
# This resource MUST wait for step_1_foundation to complete
resource "null_resource" "step_2_framework" {
  # This is the KEY: depends_on creates an explicit dependency
  depends_on = [null_resource.step_1_foundation]

  triggers = {
    timestamp = timestamp()
    step      = "framework"
    order     = 2  # This is step 2
  }

  provisioner "local-exec" {
    command = "echo 'Step 2: Framework built on foundation'"
  }
}

# ----------------------------------------------------------------------------
# Step 3: Create the THIRD resource that depends on the second
# ----------------------------------------------------------------------------
# This resource MUST wait for step_2_framework to complete
resource "null_resource" "step_3_completion" {
  # This depends on the second resource, creating a chain
  depends_on = [null_resource.step_2_framework]

  triggers = {
    timestamp = timestamp()
    step      = "completion"
    order     = 3  # This is step 3
  }

  provisioner "local-exec" {
    command = "echo 'Step 3: Project completed'"
  }
}

# ============================================================================
# VALIDATION: Submit your solution to get the flag
# ============================================================================
resource "ctfchallenge_flag_validator" "terraform_basics" {
  # Specify which challenge this is
  challenge_id = "terraform_basics"
  
  # Provide the flag (you know this from the challenge description)
  flag = "flag{t3rr4f0rm_d3p3nd3nc13s}"

  # PROOF OF WORK: Show that you created the dependency chain
  # This must be a comma-separated list of your resource IDs
  proof_of_work = {
    dependencies = join(",", [
      null_resource.step_1_foundation.id,
      null_resource.step_2_framework.id,
      null_resource.step_3_completion.id,
    ])
  }
}

# ============================================================================
# OUTPUT: Display the result
# ============================================================================
output "challenge_01_result" {
  description = "Result of Challenge 1"
  value       = ctfchallenge_flag_validator.terraform_basics.message
}

output "challenge_01_points" {
  description = "Points earned"
  value       = ctfchallenge_flag_validator.terraform_basics.points
}
```

---

### Step 3: Initialize Terraform

**Run the initialization command:**
```bash
terraform init
```

**Expected Output:**
```
Initializing the backend...

Initializing provider plugins...
- Finding omghozlan/ctfchallenge versions matching "~> 1.0"...
- Finding hashicorp/null versions matching "~> 3.2"...
- Installing omghozlan/ctfchallenge v1.0.x...
- Installing hashicorp/null v3.2.x...

Terraform has been successfully initialized!
```

✅ **Success Indicator:** You see "Terraform has been successfully initialized!"

---

### Step 4: Preview Your Solution

**Run the plan command:**
```bash
terraform plan
```

**What to Look For:**

You should see Terraform planning to create **4 resources**:
```
Terraform will perform the following actions:

  # ctfchallenge_flag_validator.terraform_basics will be created
  + resource "ctfchallenge_flag_validator" "terraform_basics" {
      + challenge_id = "terraform_basics"
      + flag         = (sensitive value)
      + id           = (known after apply)
      + message      = (known after apply)
      + points       = (known after apply)
      + validated    = (known after apply)
      ...
    }

  # null_resource.step_1_foundation will be created
  + resource "null_resource" "step_1_foundation" {
      + id       = (known after apply)
      + triggers = {
          + "order"     = "1"
          + "step"      = "foundation"
          + "timestamp" = "2024-01-15T10:30:00Z"
        }
    }

  # null_resource.step_2_framework will be created
  + resource "null_resource" "step_2_framework" {
      + id       = (known after apply)
      + triggers = {
          + "order"     = "2"
          + "step"      = "framework"
          + "timestamp" = "2024-01-15T10:30:00Z"
        }
    }

  # null_resource.step_3_completion will be created
  + resource "null_resource" "step_3_completion" {
      + id       = (known after apply)
      + triggers = {
          + "order"     = "3"
          + "step"      = "completion"
          + "timestamp" = "2024-01-15T10:30:00Z"
        }
    }

Plan: 4 to add, 0 to change, 0 to destroy.
```

✅ **Success Indicator:** "Plan: 4 to add, 0 to change, 0 to destroy"

---

### Step 5: Apply Your Solution

**Run the apply command:**
```bash
terraform apply
```

**You'll be prompted to confirm:**
```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

**Type:** `yes` and press Enter

---

### Step 6: Watch the Magic Happen! 🎉

**During execution, you'll see:**

```
null_resource.step_1_foundation: Creating...
null_resource.step_1_foundation: Provisioning with 'local-exec'...
null_resource.step_1_foundation (local-exec): Step 1: Foundation laid
null_resource.step_1_foundation: Creation complete after 1s [id=1234567890]

null_resource.step_2_framework: Creating...
null_resource.step_2_framework: Provisioning with 'local-exec'...
null_resource.step_2_framework (local-exec): Step 2: Framework built on foundation
null_resource.step_2_framework: Creation complete after 1s [id=2345678901]

null_resource.step_3_completion: Creating...
null_resource.step_3_completion: Provisioning with 'local-exec'...
null_resource.step_3_completion (local-exec): Step 3: Project completed
null_resource.step_3_completion: Creation complete after 1s [id=3456789012]

ctfchallenge_flag_validator.terraform_basics: Creating...
ctfchallenge_flag_validator.terraform_basics: Creation complete after 0s [id=terraform_basics-1234567890]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

challenge_01_result = "🎉 Congratulations! You solved 'Terraform Basics' and earned 100 points!"
challenge_01_points = 100
```

---

### Step 7: Celebrate! 🏆

**You'll see the success message:**

```
🎉 Congratulations! You solved 'Terraform Basics' and earned 100 points!
```

**View your outputs:**
```bash
terraform output challenge_01_result
```

**Output:**
```
"🎉 Congratulations! You solved 'Terraform Basics' and earned 100 points!"
```

---

## 📊 Verify Your Success

### Check Your Progress

```bash
terraform output completion_percentage
```

**If this is your first challenge:**
```
"12.5%"
```
(1 out of 8 challenges = 12.5%)

### View Detailed Results

```bash
terraform output -json challenge_results | jq
```

**You'll see:**
```json
{
  "terraform_basics": {
    "validated": true,
    "points": 100,
    "message": "🎉 Congratulations! You solved 'Terraform Basics' and earned 100 points!"
  },
  ...
}
```

---

## 🔍 Understanding What Happened

### 1. **Resource Creation Order**

Terraform created your resources in this exact order:
1. `step_1_foundation` (no dependencies)
2. `step_2_framework` (depends on #1)
3. `step_3_completion` (depends on #2)
4. `flag_validator` (validates your solution)

### 2. **The Proof of Work**

The validator received:
```
dependencies = "1234567890,2345678901,3456789012"
```

This proves you created 3 resources in a dependency chain.

### 3. **Flag Validation**

The provider checked:
- ✅ You provided the correct flag: `flag{t3rr4f0rm_d3p3nd3nc13s}`
- ✅ Your proof of work contains 3 resource IDs
- ✅ All requirements met → **100 points awarded!**

---

## 🎓 What You Learned

1. **Resource Dependencies:** How to make one resource wait for another
2. **depends_on Meta-Argument:** Explicit dependency declaration
3. **Execution Order:** Terraform respects dependencies when creating resources
4. **Resource References:** Using `resource_type.resource_name.id` to reference resources
5. **Provider Interaction:** How to submit solutions to the CTF provider

---

## 🐛 Troubleshooting

### Problem: "Provider not found"

**Solution:**
```bash
rm -rf .terraform .terraform.lock.hcl
terraform init
```

### Problem: "Challenge failed: create at least 3 dependent resources"

**Check:**
- You have exactly 3 `null_resource` blocks
- Each has `depends_on` pointing to the previous one
- Your `proof_of_work` includes all 3 resource IDs

### Problem: "Incorrect flag"

**Check:**
- Flag is exactly: `flag{t3rr4f0rm_d3p3nd3nc13s}`
- No extra spaces or quotes
- Correct spelling

---

## 📁 Complete Working Files

### Minimal Working Example

If you want the absolute minimum code:

**`challenge-01-minimal.tf`:**
```hcl
resource "null_resource" "a" {}

resource "null_resource" "b" {
  depends_on = [null_resource.a]
}

resource "null_resource" "c" {
  depends_on = [null_resource.b]
}

resource "ctfchallenge_flag_validator" "terraform_basics" {
  challenge_id = "terraform_basics"
  flag         = "flag{t3rr4f0rm_d3p3nd3nc13s}"

  proof_of_work = {
    dependencies = join(",", [
      null_resource.a.id,
      null_resource.b.id,
      null_resource.c.id,
    ])
  }
}

output "result" {
  value = ctfchallenge_flag_validator.terraform_basics.message
}
```

**Run it:**
```bash
terraform init
terraform apply
```

**Result:**
```
🎉 Congratulations! You solved 'Terraform Basics' and earned 100 points!
```

---

## 🎯 Next Steps

Congratulations on completing your first challenge! 🎉

### Ready for More?

Try these challenges next (in order of difficulty):

1. ✅ **Terraform Basics** (100 pts) - COMPLETED!
2. ⬜ **Data Source Detective** (150 pts) - Beginner
3. ⬜ **State Secrets** (200 pts) - Beginner  
4. ⬜ **For-Each Wizard** (250 pts) - Intermediate
5. ⬜ **Dynamic Blocks** (300 pts) - Intermediate
6. ⬜ **Expression Expert** (350 pts) - Intermediate
7. ⬜ **Module Master** (400 pts) - Advanced
8. ⬜ **Cryptographic Compute** (500 pts) - Advanced

### View All Challenges

```bash
terraform output all_challenges
```

### Get Hints (If Stuck)

Edit `terraform.tfvars`:
```hcl
enable_hints = true
hint_levels = {
  data_source_detective = 0  # Next challenge
}
```

---

## 📝 Quick Reference

### Essential Commands

```bash
# Initialize
terraform init

# Preview changes
terraform plan

# Apply solution
terraform apply

# View outputs
terraform output challenge_01_result
terraform output completion_percentage

# Clean up (reset)
terraform destroy
```

### File Structure

```
your-project/
├── terraform.tfvars              # Your configuration
├── solutions/
│   └── challenge-01-terraform-basics.tf  # Your solution
└── (other files...)
```

---

## 🏆 Achievement Unlocked!

**🥉 First Steps** - Complete your first Terraform CTF challenge  
**📚 Dependency Master** - Understand resource dependencies  
**🎯 100 Points** - 1/8 challenges complete (2,150 points remaining)

Keep going! You're on your way to mastering Terraform! 🚀

---

**Need help?** Check the `docs/` folder or enable hints in `terraform.tfvars`!