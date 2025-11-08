variable "challenges_enabled" {
  description = "Map of challenge IDs to enabled status"
  type        = map(bool)
}

variable "challenge_metadata" {
  description = "Metadata for all challenges"
  type = map(object({
    id         = string
    name       = string
    flag       = string
    points     = number
    difficulty = string
    category   = string
  }))
}

variable "common_tags" {
  description = "Common tags to apply"
  type        = map(string)
}

variable "enable_hints" {
  description = "Whether to request hints"
  type        = bool
}

variable "hint_levels" {
  description = "Hint levels for each challenge"
  type        = map(number)
}