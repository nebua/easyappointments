#!/bin/sh
# Based on: https://gist.github.com/aslafy-z/d244f87cf5647669d8d191808c7215dc
set -e

if [ -z "$1" ]; then
  echo "Usage: bash generateConfig.sh  <config.php-path>"
  exit 1
fi

WP_CONFIG_FILE=$1

# Ensure all variables are bound
if \
  [ -z "$BASE_URL" ] || [ -z "$LANGUAGE" ] || [ -z "$DEBUG_MODE" ] || \
  [ -z "$DB_NAME" ] || [ -z "$DB_HOST" ] || [ -z "$DB_USERNAME" ] || [ -z "$DB_PASSWORD" ] || \
  [ -z "$GOOGLE_SYNC_FEATURE" ] || [ -z "$GOOGLE_PRODUCT_NAME" ] || [ -z "$GOOGLE_CLIENT_ID" ] || \
  [ -z "$GOOGLE_CLIENT_SECRET" ] || [ -z "$GOOGLE_API_KEY" ]; 
  then
  echo "All variables have to be defined."
  exit 1
fi

# Original wp-config.php file from Wordpress 4.9.6
cat > $WP_CONFIG_FILE << 'EOM'
<?php
/* ----------------------------------------------------------------------------
 * Easy!Appointments - Open Source Web Scheduler
 *
 * @package     EasyAppointments
 * @author      A.Tselegidis <alextselegidis@gmail.com>
 * @copyright   Copyright (c) 2013 - 2020, Alex Tselegidis
 * @license     http://opensource.org/licenses/GPL-3.0 - GPLv3
 * @link        http://easyappointments.org
 * @since       v1.0.0
 * ---------------------------------------------------------------------------- */

/**
 * Easy!Appointments Configuration File
 *
 * Set your installation BASE_URL * without the trailing slash * and the database
 * credentials in order to connect to the database. You can enable the DEBUG_MODE
 * while developing the application.
 *
 * Set the default language by changing the LANGUAGE constant. For a full list of
 * available languages look at the /application/config/config.php file.
 *
 * IMPORTANT:
 * If you are updating from version 1.0 you will have to create a new "config.php"
 * file because the old "configuration.php" is not used anymore.
 */

class Config {

    // ------------------------------------------------------------------------
    // GENERAL SETTINGS
    // ------------------------------------------------------------------------

    const BASE_URL      = 'put your unique phrase here';
    const LANGUAGE      = 'put your unique phrase here';
    const DEBUG_MODE    = FALSE;

    // ------------------------------------------------------------------------
    // DATABASE SETTINGS
    // ------------------------------------------------------------------------

    const DB_HOST       = 'put your unique phrase here';
    const DB_NAME       = 'put your unique phrase here';
    const DB_USERNAME   = 'put your unique phrase here';
    const DB_PASSWORD   = 'put your unique phrase here';

    // ------------------------------------------------------------------------
    // GOOGLE CALENDAR SYNC
    // ------------------------------------------------------------------------

    const GOOGLE_SYNC_FEATURE   = FALSE;
    const GOOGLE_PRODUCT_NAME   = 'put your unique phrase here';
    const GOOGLE_CLIENT_ID      = 'put your unique phrase here';
    const GOOGLE_CLIENT_SECRET  = 'put your unique phrase here';
    const GOOGLE_API_KEY        = 'put your unique phrase here';

}

/* End of file config.php */
/* Location: ./config.php */

EOM


sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $BASE_URL | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $LANGUAGE | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $DB_HOST | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $DB_NAME | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $DB_USERNAME | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $DB_PASSWORD | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $GOOGLE_PRODUCT_NAME | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $GOOGLE_CLIENT_ID | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $GOOGLE_CLIENT_SECRET | sed -e 's/[\/&]/\\&/g')/"
sed -i $WP_CONFIG_FILE -e "1,/put your unique phrase here/s/put your unique phrase here/$(echo $GOOGLE_API_KEY | sed -e 's/[\/&]/\\&/g')/"
