package Ridiculously::Long::Package::Name::ConstructorIsNamedBuild::Elsewhere;

sub build {
	my ($class, @args) = @_;
	return bless \@args, $class;
}

1;
