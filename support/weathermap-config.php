<?php
/*
 +-------------------------------------------------------------------------+
 | Copyright (C) 2004-2024 The Cacti Group                                 |
 |                                                                         |
 | This program is free software; you can redistribute it and/or           |
 | modify it under the terms of the GNU General Public License             |
 | as published by the Free Software Foundation; either version 2          |
 | of the License, or (at your option) any later version.                  |
 |                                                                         |
 | This program is distributed in the hope that it will be useful,         |
 | but WITHOUT ANY WARRANTY; without even the implied warranty of          |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           |
 | GNU General Public License for more details.                            |
 +-------------------------------------------------------------------------+
 | Cacti: The Complete RRDTool-based Graphing Solution                     |
 +-------------------------------------------------------------------------+
 | This code is designed, written, and maintained by the Cacti Group. See  |
 | about.php and/or the AUTHORS file for specific developer information.   |
 +-------------------------------------------------------------------------+
 | http://www.cacti.net/                                                   |
 +-------------------------------------------------------------------------+
*/

/**
 * These two settings need to be defined per your Cacti install.  In legacy
 * versions of weathermap, these two files were located in the plugin
 * directory.  However, in Cacti 1.3, the archive function will interfere
 * in that locations setting.  So, pick a location that is owned by
 * the apache user, but is not in the Cacti base path.  Ensure that
 * the path's end with a '/'.
 */
$configdir = '/var/www/html/cacti/plugins/weathermap/configs/';
$outputdir = '/var/www/html/cacti/plugins/weathermap/output/';

/* we will define them here */
if (!defined('WM_CONFIGDIR')) {
        define('WM_CONFIGDIR', $configdir);
}

if (!defined('WM_OUTPUTDIR')) {
        define('WM_OUTPUTDIR', $outputdir);
}
