package LCS::Similar;

use 5.010001;
use strict;
use warnings;
our $VERSION = '0.01';
#use utf8;
use Data::Dumper;


sub new {
  my $class = shift;
  # uncoverable condition false
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}

sub LCS {
  my ($self, $X, $Y, $compare) = @_;

  $compare //= sub { $_[0] eq $_[0] };

  my $similarity = {};

  my $m = scalar @$X;
  my $n = scalar @$Y;

  my $c = [];
  my ($i,$j);
  for ($i=0;$i<=$m;$i++) {
    for ($j=0;$j<=$n;$j++) {
      $c->[$i][$j]=0;
    }
  }
  for ($i=1;$i<=$m;$i++) {
    for ($j=1;$j<=$n;$j++) {
      if ( my $sim = $X->[$i-1] eq $Y->[$j-1]) {
        $c->[$i][$j] = $c->[$i-1][$j-1] + $sim;
      }
      #elsif (similarity($X->[$i-1],$Y->[$j-1]) > 0.7) {
      #  $c->[$i][$j] = $c->[$i-1][$j-1]+similarity($X->[$i-1],$Y->[$j-1]);
      #}
      else {
        $c->[$i][$j] = max($c->[$i][$j-1], $c->[$i-1][$j]);
      }
    }
  }
  my $path = $self->_lcs($X,$Y,$c,$m,$n,[]);

  return $path;
}


sub max {
  ($_[0] > $_[1]) ? $_[0] : $_[1];
}


sub _lcs {
  my ($self,$X,$Y,$c,$i,$j,$L) = @_;

  while ($i > 0 && $j > 0) {
    if ($X->[$i-1] eq $Y->[$j-1]) {
      unshift @{$L},[$i-1,$j-1];
      $i--;
      $j--;
    }
    elsif ($c->[$i][$j] == $c->[$i-1][$j]) {
      $i--;
    }
    else {
      $j--;
    }
  }
  return $L;
}

1;

__END__

=head1 NAME

LCS::Similar - allow differences in the compared elements of
                 Longest Common Subsequence (LCS) Algorithm

=begin html

<a href="https://travis-ci.org/wollmers/LCS-BV"><img src="https://travis-ci.org/wollmers/LCS-BV.png" alt="LCS-BV"></a>
<a href='https://coveralls.io/r/wollmers/LCS-BV?branch=master'><img src='https://coveralls.io/repos/wollmers/LCS-BV/badge.png?branch=master' alt='Coverage Status' /></a>
<a href='http://cpants.cpanauthors.org/dist/LCS-BV'><img src='http://cpants.cpanauthors.org/dist/LCS-BV.png' alt='Kwalitee Score' /></a>
<a href="http://badge.fury.io/pl/LCS-BV"><img src="https://badge.fury.io/pl/LCS-BV.svg" alt="CPAN version" height="18"></a>

=end html

=head1 SYNOPSIS

  use LCS::BV;

  $alg = LCS::BV->new;
  @lcs = $alg->LCS(\@a,\@b);

=head1 ABSTRACT

LCS::Similar allows differences in the compared elements.

=head1 DESCRIPTION

=head2 CONSTRUCTOR

=over 4

=item new()

Creates a new object which maintains internal storage areas
for the LCS computation.  Use one of these per concurrent
LCS() call.

=back

=head2 METHODS

=over 4


=item LCS(\@a,\@b)

Finds a Longest Common Subsequence, taking two arrayrefs as method
arguments. It returns an array reference of corresponding
indices, which are represented by 2-element array refs.

The third argument is a subroutine comparing two elements and
returning a number between 0 and 1. Where 0 means unequal and 1 means equal.

Without a subroutine the module falls back to string comparison.


=back

=head2 EXPORT

None by design.

=head1 SEE ALSO

Algorithm::Diff

=head1 AUTHOR

Helmut Wollmersdorfer E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=begin html

<a href='http://cpants.cpanauthors.org/author/wollmers'><img src='http://cpants.cpanauthors.org/author/wollmers.png' alt='Kwalitee Score' /></a>

=end html

=head1 COPYRIGHT AND LICENSE

Copyright 2015 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
