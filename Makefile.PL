use ExtUtils::MakeMaker;

use strict;

my $online_tests = ExtUtils::MakeMaker::prompt('Do you want to perform online tests during "make test" phase?', 'no') =~ /^\s*(y)/i;

my $tests = join ' ', glob ($online_tests ? 't/0*.t t/m*.t' : 't/0*.t');

if($online_tests) {
	my $person_test = ExtUtils::MakeMaker::prompt('Do you want to perform online tests for IMDB persons during "make test" phase?', 'no') =~ /^\s*(y)/i;

	$tests .= ' ' . join ' ', glob 't/p*.t' if $person_test;
}

WriteMakefile(
    NAME              	=> 'IMDB::Film',
    VERSION_FROM      	=> 'lib/IMDB/BaseClass.pm', 
	PREREQ_PM         	=> {
							'HTML::TokeParser' 	=> 2.28,
							'LWP::Simple'		=> 1.41,
							'Cache::FileCache'	=> 0, 
							'Carp'				=> 0,
							'Error'				=> 0,
							'Digest::SHA1'		=> 0,
					}, 
					
    test           => {TESTS => $tests},
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  	=> 'lib/IMDB/Film.pm', 
       AUTHOR         	=> 'Michael Stepanov <stepanov.michael@gmail.com>') : ()),
);