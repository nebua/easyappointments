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

use Symfony\Component\Dotenv\Dotenv;
 
require_once __DIR__.'/vendor/autoload.php';
 
$path = __DIR__.'/.env';
$dotenv = new Dotenv();
$dotenv->load($path);

putenv("BASE_URL=".$_ENV['BASE_URL']);
putenv("LANGUAGE=".$_ENV['LANGUAGE']);
putenv("DEBUG_MODE=".$_ENV['DEBUG_MODE']);

putenv("DB_HOST=".$_ENV['DB_HOST']);
putenv("DB_NAME=".$_ENV['DB_NAME']);
putenv("DB_USERNAME=".$_ENV['DB_USERNAME']);
putenv("DB_PASSWORD=".$_ENV['DB_PASSWORD']);

putenv("GOOGLE_SYNC_FEATURE=".$_ENV['GOOGLE_SYNC_FEATURE']);
putenv("GOOGLE_PRODUCT_NAME=".$_ENV['GOOGLE_PRODUCT_NAME']);
putenv("GOOGLE_CLIENT_ID=".$_ENV['GOOGLE_CLIENT_ID']);
putenv("GOOGLE_CLIENT_SECRET=".$_ENV['GOOGLE_CLIENT_SECRET']);
putenv("GOOGLE_API_KEY=".$_ENV['GOOGLE_API_KEY']);


 class Config {
 
    // ------------------------------------------------------------------------
    // GENERAL SETTINGS
    // ------------------------------------------------------------------------
    const BASE_URL    =   "<?= getenv('BASE_URL'); ?>";
    const LANGUAGE      = "<?= getenv('LANGUAGE'); ?>";
    const DEBUG_MODE    = "<?= getenv('DEBUG_MODE'); ?>";

    // ------------------------------------------------------------------------
    // DATABASE SETTINGS
    // ------------------------------------------------------------------------

    const DB_HOST       = "<?= getenv('DB_HOST'); ?>";
    const DB_NAME       = "<?= getenv('DB_NAME'); ?>";
    const DB_USERNAME   = "<?= getenv('DB_USERNAME'); ?>";
    const DB_PASSWORD   = "<?= getenv('DB_PASSWORD'); ?>";

    // ------------------------------------------------------------------------
    // GOOGLE CALENDAR SYNC
    // ------------------------------------------------------------------------

    const GOOGLE_SYNC_FEATURE   = "<?= getenv('GOOGLE_SYNC_FEATURE'); ?>";
    const GOOGLE_PRODUCT_NAME   = "<?= getenv('GOOGLE_PRODUCT_NAME'); ?>";
    const GOOGLE_CLIENT_ID      = "<?= getenv('GOOGLE_CLIENT_ID'); ?>";
    const GOOGLE_CLIENT_SECRET  = "<?= getenv('GOOGLE_CLIENT_SECRET'); ?>";
    const GOOGLE_API_KEY        = "<?= getenv('GOOGLE_API_KEY'); ?>";

} 

/* End of file config.php */
/* Location: ./config.php */
