variable "cluster_log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace to create."
  type        = string
  default     = "chatbotworkspace"
}
variable "prefix" {
  description = "The prefix to use for all resources."
  type        = string
  default     = "chatbot"
}