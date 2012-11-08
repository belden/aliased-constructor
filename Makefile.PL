use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME                => 'aliased::constructor',
	AUTHOR              => 'Belden Lyman <belden@cpan.org>',
	VERSION_FROM        => 'lib/aliased/constructor.pm',
	ABSTRACT_FROM       => 'lib/aliased/constructor.pm',
	PL_FILES            => {},
	PREREQ_PM => {
    'Test::More'      => 0,
  },
  META_MERGE => {
    resources => {
      bugtracker => 'https://github.com/belden/aliased-constructor/issues',
    },
  },
  dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
  clean               => { FILES => 'aliased-constructor-*' },
 );
