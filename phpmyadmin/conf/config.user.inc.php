<?php

$cfg['blowfish_secret'] = 'LNMP.org_1668224956652_VPSer.net';
/*
 * Servers configuration
 */
$i = 0;

/*
 * First server
 */
$i++;
/* Authentication type */
$cfg['Servers'][$i]['auth_type'] = 'cookie';
/* Server parameters */
$cfg['Servers'][$i]['host'] = 'host.docker.internal';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['compress'] = false;
/* Select mysql if your server does not have mysqli */
$cfg['Servers'][$i]['extension'] = 'mysqlnd';
$cfg['Servers'][$i]['AllowNoPassword'] = false;


$cfg['UploadDir'] = 'upload';
$cfg['SaveDir'] = 'save';
$cfg['VersionCheck'] = false;