#!/usr/bin/env bash

LOG_FILE="amazon_setup.log"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

check_permissions() {
  touch "$LOG_FILE" 2> /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: You do not have the required permissions to run this script. Exiting."
    exit 1
  fi
}

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

set_up_seller_account() {
  # Code for setting up an Amazon Seller Account
  log "Opening Amazon Seller Account creation page in Google Chrome..."
  account_creation_url="https://www.amazon.com/seller-account-creation"
  open_chrome "$account_creation_url"
}

set_up_storefront() {
  # Code for setting up an Amazon storefront
  log "Opening Amazon Storefront setup page in Google Chrome..."
  storefront_setup_url="https://www.amazon.com/storefront-setup"
  open_chrome "$storefront_setup_url"
}

promote_storefront() {
  # Code for promoting an Amazon storefront
  log "Opening Amazon Storefront promotion page in Google Chrome..."
  storefront_promotion_url="https://www.amazon.com/storefront-promotion"
  open_chrome "$storefront_promotion_url"
}

check_permissions
log "Script started"

echo "Welcome to the Amazon Seller Account and Storefront Setup and Promotion script!"
echo "Which task would you like to perform?"

TASK_SELLER_ACCOUNT=1
TASK_STOREFRONT=2
TASK_PROMOTION=3

echo "$TASK_SELLER_ACCOUNT. Set up an Amazon Seller Account"
echo "$TASK_STOREFRONT. Set up an Amazon storefront"
echo "$TASK_PROMOTION. Promote an Amazon storefront"

while true; do
  read -p "Please enter the number of the task you want to perform: " task

  if [ "$task" == "$TASK_SELLER_ACCOUNT" ]; then
    set_up_seller_account
    break
  elif [ "$task" == "$TASK_STOREFRONT" ]; then
    set_up_storefront
    break
  elif [ "$task" == "$TASK_PROMOTION" ]; then
    promote_storefront
    break
  else
    log "Invalid task number entered"
    echo "Invalid task number. Please enter a valid task number."
  fi
done

log "Script finished"
