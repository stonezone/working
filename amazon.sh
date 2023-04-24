#!/bin/bash

open_chrome() {
  url="$1"

  if [[ "$OSTYPE" == "darwin"* ]]; then
    open -a "Google Chrome" "$url"
  else
    google-chrome "$url"
  fi
}

set_up_seller_account() {
  # Code for setting up an Amazon Seller Account
  echo "Opening Amazon Seller Account creation page in Google Chrome..."
  account_creation_url="https://www.amazon.com/seller-account-creation"
  open_chrome "$account_creation_url"
}

set_up_storefront() {
  # Code for setting up an Amazon storefront
  echo "Opening Amazon Storefront setup page in Google Chrome..."
  storefront_setup_url="https://www.amazon.com/storefront-setup"
  open_chrome "$storefront_setup_url"
}

promote_storefront() {
  # Code for promoting an Amazon storefront
  echo "Opening Amazon Storefront promotion page in Google Chrome..."
  storefront_promotion_url="https://www.amazon.com/storefront-promotion"
  open_chrome "$storefront_promotion_url"
}

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
    echo "Invalid task number. Please enter a valid task number."
  fi
done
