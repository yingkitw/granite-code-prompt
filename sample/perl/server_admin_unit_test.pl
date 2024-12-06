# Assisted by watsonx Code Assistant 
# watsonx Code Assistant did not check whether this code suggestion might be similar to third party code.
use Test::More;
use Test::Exception;
use Test::Warnings;
use Test::Deep;
use Test::MockModule;

# Test check_disk_usage
{
    my $mock_df = Test::MockModule->new('File::Which');
    $mock_df->mock('df', sub { return "Filesystem\tSize\tUsed\tAvail\tUse%\n/dev/sda1\t499G\t4.8G\t446G\t10%\n" });

    my $output = capture { check_disk_usage() };
    like($output, qr/Filesystem\tSize\tUsed\tAvail\tUse%/, "Output contains expected header");
    like($output, qr/\d+G\t\d+G\t\d+G\t\d+%/, "Output contains expected data");
}

# Test check_logged_in_users
{
    my $mock_who = Test::MockModule->new('File::Which');
    $mock_who->mock('who', sub { return "root\tpts/0\t2019-01-01 00:00 (192.168.0.1)\nuser\tpts/1\t2019-01-01 00:00 (192.168.0.2)\n" });

    my $output = capture { check_logged_in_users() };
    like($output, qr/root\tpts\/0\t2019-01-01 00:00 \(192.168.0.1\)/, "Output contains expected root user");
    like($output, qr/user\tpts\/1\t2019-01-01 00:00 \(192.168.0.2\)/, "Output contains expected user");
}

# Test monitor_processes
{
    my $mock_ps = Test::MockModule->new('File::Which');
    $mock_ps->mock('ps', sub { return "PID\tCOMMAND\t%CPU\t%MEM\n1\ttop\t0.1\t0.2\n2\tvi\t0.3\t0.4\n" });

    my $output = capture { monitor_processes() };
    like($output, qr/PID\tCOMMAND\t%CPU\t%MEM/, "Output contains expected header");
    like($output, qr/1\ttop\t0.1\t0.2/, "Output contains expected data for top process");
    like($output, qr/2\tvi\t0.3\t0.4/, "Output contains expected data for vi process");
}

# Test restart_service
{
    my $mock_systemctl = Test::MockModule->new('File::Which');
    $mock_systemctl->mock('systemctl', sub { return 0; });

    restart_service('httpd');
    $mock_systemctl->verify('systemctl', called(1), 'Expected systemctl to be called once');
    $mock_systemctl->verify('systemctl', called_with('restart', 'httpd'), 'Expected systemctl to be called with restart and httpd arguments');
}

done_testing();
