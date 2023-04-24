#!/usr/bin/env bash
set -euo pipefail

# Log file for storing the logs
LOG_FILE="amazon_setup.log"

# Logging function to log messages with timestamps
log() {
  printf "%s - %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$1" | tee -a "$LOG_FILE"
}

# Function to check permissions to create the log file
check_permissions() {
  touch "$LOG_FILE" 2> /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: You do not have the required permissions to run this script. Exiting."
    exit 1
  fi
}

# Function to open Google Chrome with the specified URL
open_chrome() {
  url="$1"

  if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v open &> /dev/null; then
      log "Error: 'open' command not found. Please install it or use a different browser."
      exit 1
    fi
    open -a "Google Chrome" "$url"
  else
    if ! command -v google-chrome &> /dev/null; then
      log "Error: Google Chrome not found. Please install it or use a different browser."
      exit 1
    fi
    google-chrome "$url"
  fi
}

# Function to set up an Amazon Seller Account
set_up_seller_account() {
  log "Opening Amazon Seller Account creation page in Google Chrome..."
  account_creation_url="https://www.amazon.com/seller-account-creation"
  open_chrome "$account_creation_url"
}

# Function to set up an Amazon storefront
set_up_storefront() {
  log "Opening Amazon Storefront setup page in Google Chrome..."
  storefront_setup_url="https://www.amazon.com/storefront-setup"
  open_chrome "$storefront_setup_url"
}

# Function to promote an Amazon storefront
promote_storefront() {
  log "Opening Amazon Storefront promotion page in Google Chrome..."
  storefront_promotion_url="https://www.amazon.com/storefront-promotion"
  open_chrome "$storefront_promotion_url"
}

# Main script
check_permissions
log "Script started"

printf "Welcome to the Amazon Seller Account and Storefront Setup and Promotion script!\n"
printf "Which task would you like to perform?\n"

TASK_SELLER_ACCOUNT=1
TASK_STOREFRONT=2
TASK_PROMOTION=3

printf "%s. Set up an Amazon Seller Account\n" "$TASK_SELLER_ACCOUNT"
printf "%s. Set up an Amazon storefront\n" "$TASK_STOREFRONT"
printf "%s. Promote an Amazon storefront\n" "$TASK_PROMOTION"

while true; do
  read -rp "Please enter the number of the task you want to perform: " task

  if [[ "$task" == "$TASK_SELLER_ACCOUNT" ]]; then
    set_up_seller_account
    break
  elif [[ "$task" == "$TASK_STOREFRONT" ]]; then
    set_up_storefront
    break
  elif [[ "$task" == "$TASK_PROMOTION" ]]; then
    promote_storefront
    break
  else
    log "Invalid task number entered"
    printf "Invalid task number. Please enter a valid task number.\n"
  fi
done

log "Script finished"
