#!/usr/local/bin/perl -w
#
use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;


my $type;

my $hostname;
my $remoteserver;
my $username;
my $password;
my $remotedir;
my $remotename;
my $localname;
my $keydir;
my $regex;
my $multi_file;
my $extension;
my $over_ride;
my $exp_phrase;

GetOptions (
	"over" => \$override,
	"type=s" => \$type,
	"h=s" => \$hostname,
	"rserv=s" => \$remoteserver,
	"u=s" => \$username,
	"p=s" => \$password,
	"rdir=s" => \$remotedir,
	"rname=s" => \$remotename,
	"l=s" => \$localname,
	"k=s" => \$keydir,
	"r=s" => \$regex,
	"m" => \$multi_file,
	"x=s" => \$extension,
	"ow" => \$over_write,
	"e=s" => \$exp_phrase,
	);


print "TYPE $type\n";
print "KEYDIR $keydir\n";
print "REGEX $regex\n";
print "MULTI_FILE $multi_file\n";
print "EXTENSION $extension\n";
print "OVER_WRITE $over_write\n";
print "EXPECT PHRASE $exp_phrase\n";


# Output 

# PSOFT hcsqltst02:~/filetran> ./getopt_long.pl --type=scp -k=/home/tpensel/bin -r=*.txt -m -x=extra -o -e="What Dept do you want?:What is the name of your company?"
# TYPE scp
# KEYDIR /home/tpensel/bin
# REGEX *.txt
# MULTI_FILE 1
# EXTENSION extra
# OVER_RIDE 1
# EXPECT PHRASE What Dept do you want?:What is the name of your company?
# PSOFT hcsqltst02:~/filetran>
