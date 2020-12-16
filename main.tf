resource "azurerm_policy_definition" "OnTimeTag_policy" {
  name                  = "OnTime Tag Policy"
  policy_type           = "Custom"
  mode                  = "Indexed"
  display_name          = "OnTime Tag Policy"
  management_group_name = var.definition_management_group
  policy_rule           = file("${path.module}/policies/key-vault-soft-delete/policy-rule.json")

}
