package aliased::constructor;
use base qw(aliased);

use strict;
use warnings;

our $VERSION = 0.01;

my %constructor;

sub import {
	my ($class, $package, %args) = @_;

	$constructor{$package} = $args{-constructor} || 'new';
	@_ = ($class, $package);
	goto &aliased::import;
}

sub _export_level {
	my $super = shift->SUPER::_export_level;
	return $super + 1;
}

sub _make_alias_sub {
	my ($class, $beneficiary) = @_;
	my $constructor = $constructor{$beneficiary};
	return sub () { sub { $beneficiary->$constructor(@_) } };
}

1;

__END__

=head1 NAME

aliased::constructor - Use shorter versions of class names as constructors.

=head1 VERSION

0.01

=head1 SYNOPSIS

  # By default we assume the constructor for the class you're aliasing is named 'new'
  use aliased::constructor 'My::Company::Namespace::Customer';
  my $cust = Customer->(...);


  # If the class you're aliasing uses some other name for its constructor, you may inform aliased::constructor of that
  use aliased::constructor 'Catepillar::ConstructionEquipment::Heavy::Backhoe', -constructor => 'build';
  my $backhoe = Backhoe->(...);

=head1

C<aliased::constructor> is very similar in concept to C<aliased>, and uses it under the hood. Using C<aliased::constructor> allows
you to gloss away the name of your constructor though. The easiest way to explain the difference is with some code:

    use aliased 'My::Company::Namespace::Customer';
    my $cust = Customer->new(name => 'Bob', age => 87);

versus:

    use aliased 'My::Company::Namespace::Customer';
    my $cust = Customer->(name => 'Bob', age => 87);

This module is useful if you prefer a simpler name for constructing objects of a given class.

=head2 Implicit Construtor

The most likely use of this module is:

  use aliased::constructor 'Some::Module::Name';

C<aliased::constructor> will allow you to build construct objects by simply referring to the last part of the class name.
Thus, C<new Really::Long::Name> may be expressed more simply as C<Name>. It does this by exporting a subroutine into your
namespace with the same name as the aliased name. This subroutine invokes the constructor on the original class name.

=head2 Explicit Constructor

Occasionally you may need to alias the constructor of some module which does not use ->new as its constructor. In this case,
you may simply indicate the name of the constructor in your C<use> line, viz:

  use aliased::constructor 'Some::Module::Name', -constructor => 'build';

=head1 EXPORT

None.

=head1 BUGS

This module looks a lot like C<aliased>, but does not honor all of the functionality provided by C<aliased>.

=head1 SEE ALSO

The L<aliased> module.

=head1 THANKS

Thanks to Shutterstock, Inc. (http://shutterstock.com) for allowing me to pursue this experiment during work hours.

=head1 AUTHOR

Belden Lyman, C<< belden@cpan.org >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2012 by Belden Lyman

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.

=cut
