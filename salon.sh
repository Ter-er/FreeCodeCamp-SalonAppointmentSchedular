#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
  
  # Display available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  if [[ -z $AVAILABLE_SERVICES ]]
  then
    EXIT
  else
    echo -e "Here are our services:"
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done

    # Ask for service to render
    echo -e "\nPlease pick a service."
    read SERVICE_ID_SELECTED

    # If input is not a number
    if [[ ! $SERVICE_ID_SELECTED =~ ^[1-5]+$ ]]
    then
      # Send to main menu
      MAIN_MENU "That is not a valid input. Please select a service from 1-5."
    else 
      # Get customer info
      echo -e "\nWhat is your phone number?"
      read CUSTOMER_PHONE
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

      # If customer does not exist
      if [[ -z $CUSTOMER_NAME ]]
      then
        # Get new customer name.
        echo -e "\nWhat is your name?"
        read CUSTOMER_NAME

        # Insert new customer
        INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")

        # Get customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        # Get service time
        echo -e "\nWhat time would you be want your service scheduled? Format: 10:00 or 10am"
        read SERVICE_TIME

        # Set appointment for new customer
        INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

        # get appointment info 
        APPOINTMENT_INFO=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

        # Confirm appointment
        echo -e "\nI have put you down for a $APPOINTMENT_INFO at $SERVICE_TIME, $CUSTOMER_NAME."
      else
        # Get customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        # Get service time
        echo -e "\nWhat time would you be want your service scheduled? Format: 10:00am or 10am"
        read SERVICE_TIME

        # Set appointment for new customer
        INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

        # get appointment info 
        APPOINTMENT_INFO=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

        # Confirm appointment
        echo -e "\nI have put you down for a $APPOINTMENT_INFO at $SERVICE_TIME, $CUSTOMER_NAME."
      fi
    fi
  fi
}


MAIN_MENU