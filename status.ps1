# ============================================================================
# Terraform CTF Challenge Status Script (PowerShell)
# ============================================================================

# Enable better error handling
$ErrorActionPreference = "SilentlyContinue"

# Color functions
function Write-ColorText {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color -NoNewline
}

function Write-ColorLine {
    param(
        [string]$Text,
        [string]$Color = "White"
    )
    Write-Host $Text -ForegroundColor $Color
}

# Header
Write-Host ""
Write-Host "╔════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     Terraform CTF Challenge Status        ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Get progress bar
try {
    $progress = terraform output -raw progress_bar 2>$null
    if ($progress) {
        Write-ColorLine $progress "Blue"
        Write-Host ""
    }
} catch {
    Write-ColorLine "Error getting progress information" "Red"
}

# Get summary
try {
    $summaryJson = terraform output -json public_summary 2>$null
    if ($summaryJson) {
        $summary = $summaryJson | ConvertFrom-Json
        
        $player = $summary.player_name
        $earned = $summary.total_earned
        $possible = $summary.total_possible
        $completed = $summary.challenges_completed
        $enabled = $summary.challenges_enabled
        $remaining = $summary.remaining_points
        
        Write-ColorText "Player: " "Yellow"
        Write-ColorLine $player "White"
        
        Write-ColorText "Score: " "Yellow"
        Write-ColorLine "$earned / $possible points ($remaining remaining)" "White"
        
        Write-ColorText "Challenges: " "Yellow"
        Write-ColorLine "$completed / $enabled completed" "White"
        Write-Host ""
    }
} catch {
    Write-ColorLine "Error getting summary information" "Red"
}

# Show enabled challenge status
Write-ColorLine "Enabled Challenges:" "Cyan"
Write-ColorLine "─────────────────────────────────────────" "Gray"

try {
    $statusJson = terraform output -json challenge_status 2>$null
    if ($statusJson) {
        $status = $statusJson | ConvertFrom-Json
        
        $status.PSObject.Properties | Where-Object { $_.Value.enabled -eq $true } | ForEach-Object {
            $name = $_.Name -replace "_", " "
            $name = (Get-Culture).TextInfo.ToTitleCase($name)
            
            if ($_.Value.completed) {
                $earned = $_.Value.earned
                $points = $_.Value.points
                Write-ColorLine "✓ $name - $earned/$points points" "Green"
            } else {
                $points = $_.Value.points
                Write-ColorLine "✗ $name - $points points" "Red"
            }
        }
    }
} catch {
    Write-ColorLine "Error getting challenge status" "Red"
}

# Show disabled challenges if any
try {
    $disabledJson = terraform output -json disabled_challenges 2>$null
    if ($disabledJson) {
        $disabled = $disabledJson | ConvertFrom-Json
        
        if ($disabled.Count -gt 0) {
            Write-Host ""
            Write-ColorLine "Disabled Challenges:" "Cyan"
            Write-ColorLine "─────────────────────────────────────────" "Gray"
            
            $disabled | ForEach-Object {
                $name = $_.name
                $points = $_.points
                Write-ColorLine "⊘ $name - $points points" "Yellow"
            }
        }
    }
} catch {
    # Silently ignore if no disabled challenges
}

Write-Host ""

# Show statistics by difficulty
try {
    $statsJson = terraform output -json statistics 2>$null
    if ($statsJson) {
        $stats = $statsJson | ConvertFrom-Json
        
        Write-ColorLine "By Difficulty:" "Cyan"
        Write-ColorLine "─────────────────────────────────────────" "Gray"
        
        $beginnerCompleted = $stats.by_difficulty.beginner.completed
        $beginnerEnabled = $stats.by_difficulty.beginner.enabled
        Write-ColorText "Beginner:     " "Green"
        Write-ColorLine "$beginnerCompleted/$beginnerEnabled completed" "White"
        
        $intermediateCompleted = $stats.by_difficulty.intermediate.completed
        $intermediateEnabled = $stats.by_difficulty.intermediate.enabled
        Write-ColorText "Intermediate: " "Yellow"
        Write-ColorLine "$intermediateCompleted/$intermediateEnabled completed" "White"
        
        $advancedCompleted = $stats.by_difficulty.advanced.completed
        $advancedEnabled = $stats.by_difficulty.advanced.enabled
        Write-ColorText "Advanced:     " "Red"
        Write-ColorLine "$advancedCompleted/$advancedEnabled completed" "White"
    }
} catch {
    Write-ColorLine "Error getting statistics" "Red"
}

Write-Host ""
Write-ColorLine "Run 'terraform output challenge_results' for detailed results" "Gray"
Write-ColorLine "Run 'terraform output score_breakdown' for score breakdown" "Gray"
Write-ColorLine "Run 'terraform output statistics' for detailed statistics" "Gray"
Write-Host ""