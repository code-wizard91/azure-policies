variable "management_group_definition_location" {
    description = "The management group where this definition is defined."
}

variable "name" {
    description = "The policy name used to construct the Policy ID."
}

variable "display_name" {
    description = "Scope where policies targeting non-production should be assigned."
}

variable "assignment_scope" {
    description = "Azure scope where the policy should be assigned."
}

variable "policy_rule" {
    description = "The JSON block representing the policy rule for the definition."
}
