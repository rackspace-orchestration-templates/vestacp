import re
from fabric.api import env, run, hide, task
from envassert import detect, file, group, package, port, process, service, \
    user
from hot.utils.test import get_artifacts, http_check


def vestacp_is_responding():
    with hide('running', 'stdout'):
        homepage = run('curl --insecure https://localhost:8083/login/')
        if re.search('Vesta Control Panel', homepage):
            return True
        else:
            return False


@task
def check():
    env.platform_family = detect.detect()

    files = [
        '/usr/local/vesta/conf/vesta.conf',
        '/usr/local/vesta/conf/mysql.conf'
    ]

    for f in files:
        assert file.exists(f), '%s does not exist' % f

    port_services = [
        (80, 'nginx.conf'),
        (993, 'dovecot'),
        (995, 'dovecot'),
        (587, 'exim4'),
        (465, 'exim4'),
        (110, 'dovecot'),
        (143, 'dovecot'),
        (8080, 'apache2'),
        (8081, 'apache2'),
        (8083, 'vesta-nginx'),
        (8084, 'nginx.conf'),
        (53, 'named'),
        (21, 'vsftpd'),
        (25, 'exim4'),
        (953, 'named'),
        (8443, 'apache2'),
        (2525, 'exim4')
    ]

    for s in port_services:
        assert port.is_listening(s[0]), \
            'port %i/%s is not listening' % (s[0], s[1])

    for u in ['ftp', 'admin', 'Debian-exim']:
        assert user.exists(u), '%s user does not exist' % u

    processes = [
        'vsftpd',
        'mysqld',
        'named',
        'exim4',
        'dovecot',
        'anvil',
        'nginx',
        'vesta-nginx',
        'vesta-php'
    ]

    for p in processes:
        assert process.is_up(p), '%s is not running' % p

    services = [
        'apache2',
        'mysql',
        'bind9',
        'exim4',
        'vesta'
    ]

    for s in services:
        assert service.is_enabled(s), '%s service not enabled' % s

    assert vestacp_is_responding(), 'vestacp did not respond as expected.'


@task
def artifacts():
    env.platform_family = detect.detect()
    get_artifacts()
