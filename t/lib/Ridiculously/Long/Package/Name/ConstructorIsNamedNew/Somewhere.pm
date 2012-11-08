package Ridiculously::Long::Package::Name::ConstructorIsNamedNew::Somewhere;

sub new {
	my ($class, @args) = @_;
	return bless \@args, $class;
}

1;
