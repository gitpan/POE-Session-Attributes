use 5.008 ;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'POE::Session::Attributes',
    VERSION_FROM      => 'lib/POE/Session/Attributes.pm', # finds $VERSION
    PREREQ_PM         => {
        POE => 0,
	'Class::Data::Inheritable' => 0,
	'Class::Inspector' => 0
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/POE/Session/Attributes.pm', # retrieve abstract from module
       AUTHOR         => 'dmitry kim <dmitry.kim@gmail.com>') : ()),
);
