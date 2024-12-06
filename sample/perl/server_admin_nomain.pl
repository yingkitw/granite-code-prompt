#!/usr/bin/perl
use strict;
use warnings;


sub check_disk_usage {
    print "\n--- Disk Usage ---\n";
    my @output = `df -h`;
    print @output;
}

sub check_logged_in_users {
    print "\n--- Logged-in Users ---\n";
    my @output = `who`;
    print @output;
}

sub monitor_processes {
    print "\n--- Running Processes ---\n";
    my @output = `ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -10`;
    print "PID\tCOMMAND\t\t%CPU\t%MEM\n";
    print @output;
}

sub restart_service {
    print "\nEnter the service name to restart: ";
    chomp(my $service = <STDIN>);
    my $status = system("sudo systemctl restart $service");
    if ($status == 0) {
        print "Service '$service' restarted successfully.\n";
    } else {
        print "Failed to restart service '$service'.\n";
    }
}

