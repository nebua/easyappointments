<?php defined('BASEPATH') or exit('No direct script access allowed');

/* ----------------------------------------------------------------------------
 * Easy!Appointments - Open Source Web Scheduler
 *
 * @package     EasyAppointments
 * @author      A.Tselegidis <alextselegidis@gmail.com>
 * @copyright   Copyright (c) 2013 - 2020, Alex Tselegidis
 * @license     http://opensource.org/licenses/GPL-3.0 - GPLv3
 * @link        http://easyappointments.org
 * @since       v1.4.0
 * ---------------------------------------------------------------------------- */

/**
 * Class Migration_Add_require_phone_number_setting
 *
 * @property CI_Loader load
 * @property CI_DB_query_builder db
 * @property CI_DB_forge dbforge
 * @property Settings_Model settings_model
 */
class Migration_Add_require_phone_number_setting extends CI_Migration {
    /**
     * Migration_Add_require_phone_number_setting constructor.
     *
     * @param array $config
     */
    public function __construct($config = [])
    {
        parent::__construct($config);

        $this->load->model('settings_model');
    }

    /**
     * Upgrade method.
     */
    public function up()
    {
        try
        {
            $this->settings_model->get_setting('require_phone_number');
        }
        catch (Exception $exception)
        {
            $this->settings_model->set_setting('require_phone_number', '1');
        }
    }

    /**
     * Downgrade method.
     */
    public function down()
    {
        $this->settings_model->remove_setting('require_phone_number');
    }
}
