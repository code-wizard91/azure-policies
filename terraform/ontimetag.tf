# configure the Azure Provider
provider "azurerm" {
  version = "=2.0.0"
  features {}
}

# Define Azure Policy Definition
resource "azurerm_policy_definition" "policy" {
  name         = "OnTimeTag"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "OnTimeTag"

  policy_rule = <<POLICY_RULE
    {
    "if": {
      "allOf": [
        {
          "field": "type",
          "equals": "Microsoft.Compute/VirtualMachines"
        },
        {
          "field": "[concat('tags[', parameters('tagName'), ']')]",
          "exists": "false"
        }
      ]
    },
    "then": {
      "effect": "modify",
      "details": {
        "roleDefinitionIds": [
          "/providers/microsoft.authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
        ],
        "operations": [
          {
            "operation": "add",
            "field": "[concat('tags[', parameters('tagName'), ']')]",
            "value": "[parameters('tagValue')]"
          }
        ]
      }
    }
  }
POLICY_RULE

  parameters = <<PARAMETERS
    {
    "tagName": {
      "type": "String",
      "metadata": {
        "displayName": "Tag Name",
        "description": "Name of the tag"
      },
      "defaultValue": "OnTime"
    },
    "tagValue": {
      "type": "String",
      "metadata": {
        "displayName": "Value of Tag",
        "description": "Value of the tag"
      },
        "allowedValues": [
          "24/7",
          "12/7",
          ""
        ],
      "defaultValue": ""
    }
  }
PARAMETERS
}

# Define Azure Policy Assignment

resource "azurerm_policy_assignment" "example" {
  name                 = "example-policy-assignment"
  scope                = "/subscriptions/76cebca4-468d-413d-b840-3fc5f67cdf81"
  policy_definition_id = "${azurerm_policy_definition.policy.id}"
  description          = "Applies OnTimeTag on all VM's"
  display_name         = "OnTimeTag on all VM's"
  location             = "uksouth"
  identity { type = "SystemAssigned" }

}
