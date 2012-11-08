#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 4;

use lib grep { -d $_ } qw(./lib ./t/lib ../lib);

{
	package ugly;
	use Ridiculously::Long::Package::Name::ConstructorIsNamedNew::Somewhere;
	use Ridiculously::Long::Package::Name::ConstructorIsNamedBuild::Elsewhere;

	sub get_somewhere { Ridiculously::Long::Package::Name::ConstructorIsNamedNew::Somewhere->new(@_) }
	sub get_elsewhere { Ridiculously::Long::Package::Name::ConstructorIsNamedBuild::Elsewhere->build(@_) }
}

{
	package tidy;
	use aliased::constructor 'Ridiculously::Long::Package::Name::ConstructorIsNamedNew::Somewhere';
	use aliased::constructor 'Ridiculously::Long::Package::Name::ConstructorIsNamedBuild::Elsewhere', -constructor => 'build';

	sub get_somewhere { Somewhere->(@_) }
	sub get_elsewhere { Elsewhere->(@_) }
}

# aliased::constructor::import assumes (-constructor => 'new') by default.
{
	my $got = tidy->get_somewhere(1..10);
	my $exp = ugly->get_somewhere(1..10);
	isa_ok( $exp, 'Ridiculously::Long::Package::Name::ConstructorIsNamedNew::Somewhere' );
	is( ref($got), ref($exp), '->get_somewhere objects are in same class' );
}

# provide a different constructor if you need
{
	my $got = tidy->get_elsewhere(1..10);
	my $exp = ugly->get_elsewhere(1..10);
	isa_ok( $exp, 'Ridiculously::Long::Package::Name::ConstructorIsNamedBuild::Elsewhere' );
	is( ref($got), ref($exp), '->get_elsewhere objects are in same class' );
}


