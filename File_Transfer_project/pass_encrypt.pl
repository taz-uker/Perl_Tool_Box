#!/usr/local/bin/perl
#
# This program encrypts a password for use in the SiteID record.
#




sub encrypt_string {
    my $host = "workqagpg01";
    my $user = "gpgadmin";
    my $recipient = "453A841B";
    my $cmd = "gpg --batch --yes --no-tty --trust-model always -r $recipient -a --encrypt";
    my $string = $_[0];

    my $ssh = Net::OpenSSH->new("$user\@$host");
    $ssh->error and 
      die "Couldn't establish SSH connection: ". $ssh->error;

    my ($in, $out, $err, $pid) = $ssh->open3("$cmd") or
        die "ssh open failed: " . $ssh->error;
    print $in $string;
    close $in;

    while(<$err>) {
        print STDERR;
    }

    my @result;
    while(<$out>) {
        push(@result, $_);
    }

    return @result;
}
