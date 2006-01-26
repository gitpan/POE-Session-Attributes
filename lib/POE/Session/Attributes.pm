package POE::Session::Attributes;

use warnings;
use strict;
use POE;
use Attribute::Handlers;
use Data::Dumper

=head1 NAME

POE::Session::Attributes -- POE::Session wrapper using attributes to mark state handlers

=head1 ABSTRACT

POE::Session::Attributes is a wrapper using attributes to mark state handlers

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use POE;
    use base 'POE::Session::Attributes';

    my $foo = POE::Session::Attributes->create(
	    heap => {...},
	    args => [....],
	    options => {....},
	);
    ...

    sub _start : state {
	...
    }

=head1 DESCRIPTION

This package wraps POE::Session and permits use of a 'state' attributes to
designate state handlers.  

=head1 FUNCTIONS

=head2 create

This is the wrapper around POE::Session.  It takes 'args', 'heap' and
'options' arguments and passes them on to POE::Session. It will silently
 ignore 'inline_states', 'package_states', and 'object_states'.
The session it creates gets it's state handlers from the package where it
was called. Or from a 'package=>' option.  It'll throw a lethal exception
if package=>arg has no state attribute subroutines.

=cut

my %State;

BEGIN {
    %State = (
        package_default => {
            _start   => sub { die "no _start handler" },
            _default => sub { warn $_[STATE], ": no handler for this state" },
        }
    );
}

sub create {
    my $class = shift;

    my %passed = @_;
    my %arg;

    for (qw(args heap options)) {
	next unless (exists $passed{$_});
	$arg{$_} = $passed{$_};
    }

    my $package = $passed{package};
    $package ||= (caller)[0];

    if (not exists $State{$package}) {
	die "no states for package $package";
    }

    POE::Session->create(
	%arg,
       	inline_states => $State{$package}
    );
}

=head2 state 

The attribute handler

=cut

sub state : ATTR(CODE) {
    my ( $package, $symbol, $code, $attribute, $data ) = @_;

    $State{$package}{ *{$symbol}{NAME} } = $code;
}

=head1 AUTHOR

Chris Fedde, C<< <cfedde at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-poe-session-attributes at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=POE-Session-Attributes>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc POE::Session::Attributes

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/POE-Session-Attributes>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/POE-Session-Attributes>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=POE-Session-Attributes>

=item * Search CPAN

L<http://search.cpan.org/dist/POE-Session-Attributes>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2006 Chris Fedde, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;    # End of POE::Session::Attributes
