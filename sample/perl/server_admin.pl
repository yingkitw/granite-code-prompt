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

sub main_menu {
    while (1) {
        print "\n--- Server Administration Tool ---\n";
        print "1. Check Disk Usage\n";
        print "2. Check Logged-in Users\n";
        print "3. Monitor Top CPU Processes\n";
        print "4. Restart a Service\n";
        print "5. Exit\n";
        print "Choose an option: ";

        chomp(my $choice = <STDIN>);

        if ($choice == 1) {
            check_disk_usage();
        } elsif ($choice == 2) {
            check_logged_in_users();
        } elsif ($choice == 3) {
            monitor_processes();
        } elsif ($choice == 4) {
            restart_service();
        } elsif ($choice == 5) {
            print "Exiting... Goodbye!\n";
            last;
        } else {
            print "Invalid choice. Please try again.\n";
        }
    }
}

main_menu();
