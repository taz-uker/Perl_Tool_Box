#!/usr/bin/perl

use Net::OpenSSH;

my $encstring = '-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.13 (GNU/Linux)

hQEMA5to7fMOv0gjAQf8CYLJfW96h85jef92RLHKkr+gYyL9yxNPIa2n6o5D8bjQ
yJZ8S9e/kX78sjpT+serTJFpINTFPy4a4wRpjiuGXFiUf1U4Mzr4YF2YlGhPDSct
Sl85K9+1lT010zWr6XMa+5sL6C3WOYrGLsSz5B2DwRc+LnHyFLZnJrMSqTN1gg/T
vbQEzZ9W+hzgqWRc4OAJA6FK/GU5JweIyB3TWIwgiMaBMgwSMOzmppk0zASLWMKY
N/NOXSqDI9SXxLgBhyiVx792932/hqvlZ4uEsb6SgENqgw3/v50VNYrMnWCa4CZ4
gFWhySer4ZEcCKkivvR2GNM2liMeiuzphaPChVY3T9JJAZ7GMXU84lug8fcOjjYI
UvI9aDU3pOgddFwWm6U2Unjm1dx8R2uFAlN1KCtCAqqHiInXF+dCBh1Gi/Rrfjox
BOOY4Jsukse+Rw==
=l7sd
-----END PGP MESSAGE-----
';

print decrypt_password($encstring);

sub decrypt_password {
        my $host = "workqagpg01";
        my $user = "gpgadmin";
        my $cmd = "gpg --batch --yes --no-tty --trust-model always --decrypt";
        my $password = $_[0];

        my $ssh = Net::OpenSSH->new("$user\@$host");
        $ssh->error and
          die "Couldn't establish SSH connection: ". $ssh->error;

    my ($in, $out, $err, $pid) = $ssh->open3("$cmd") or
        die "ssh open failed: " . $ssh->error;
    print $in $password;
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

