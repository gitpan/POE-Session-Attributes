use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'POE::Session::Attributes',
    AUTHOR              => 'Chris Fedde <cfedde@cpan.org>',
    VERSION_FROM        => 'lib/POE/Session/Attributes.pm',
    ABSTRACT_FROM       => 'lib/POE/Session/Attributes.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
	'POE'        => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'POE-Session-Attributes-*' },
);
