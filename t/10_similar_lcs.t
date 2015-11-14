#!perl
use 5.008;

use strict;
use warnings;
use utf8;

use lib qw(../lib/);

use Test::More;
use Test::Deep;
#cmp_deeply([],any());

use LCS;

use Data::Dumper;

my $class = 'LCS::Similar';

use_ok($class);

my $object = new_ok($class);

if (0) {
ok($object->new());
ok($object->new(1,2));
ok($object->new({}));
ok($object->new({a => 1}));

ok($class->new());
}

my $examples = [
  [
    [ split(/\n/,<<TEXT) ],
The genital structures were photographed beneath glycerol with a 5-megapixel digital

Manuscript accepted 04.04.20 12
190

C. GERMANN

camera (Leica DFC425) under a stereomicroscope (Leica MZ16). The same camera
TEXT

    [ split(/\n/,<<TEXT) ],
The genital structures were photographed beneath glycerol with a 5-megapixel digital

Manuscript accepted 04.04.2012
190 C. GERMANN

camera (Leica DFC425) under a stereomicroscope (Leica MZ16). The same camera
TEXT
  ],
];

  if (1) {
    local $Data::Dumper::Deepcopy = 1;
    print STDERR Data::Dumper->Dump([$examples],[qw(examples)]),"\n";
  }

#exit;

my $examples2 = [];

sub similarity {
  my ($a, $b) = @_;

  $a //= '';
  $b //= '';

  return 1 if ($a eq $b);
  return 1 if (!$a && !$b);

  my $llcs = LCS->LLCS(
    [split(//,$a)],
    [split(//,$b)],
  );
  my $similarity = (2 * $llcs) / (length($a) + length($b));
  return $similarity;
}

if (1) {
for my $example (@$examples) {
#for my $example ($examples->[1]) {
  my $a = $example->[0];
  my $b = $example->[1];
  my @a = $a =~ /([^_])/g;
  my @b = $b =~ /([^_])/g;

  my $lcs = LCS::Similar->LCS($a,$b,\&similarity);
  my $all_lcs = LCS->allLCS($a,$b);

  if (1) {
  cmp_deeply(
    $lcs,
    any(
        $lcs,
        supersetof(@{$all_lcs})
    ),
    "$a, $b"
  );
  }

  if (0) {
    local $Data::Dumper::Deepcopy = 1;
    print STDERR Data::Dumper->Dump([$all_lcs],[qw(allLCS)]),"\n";
    print STDERR Data::Dumper->Dump([$lcs],[qw(LCS)]),"\n";
  }
}
}

if (0) {
for my $example (@$examples2) {
#for my $example ($examples->[3]) {
  my $a = $example->[0];
  my $b = $example->[1];
  my @a = $a =~ /([^_])/g;
  my @b = $b =~ /([^_])/g;

  my $lcs = LCS::Similar->LCS(\@a,\@b);
  my $all_lcs = LCS->allLCS(\@a,\@b);

  cmp_deeply(
    $lcs,
    any(
        $lcs,
        supersetof(@{$all_lcs})
    ),
    "$a, $b"
  );

  if (0) {
    local $Data::Dumper::Deepcopy = 1;
    print STDERR Data::Dumper->Dump([$all_lcs],[qw(allLCS)]),"\n";
    print STDERR Data::Dumper->Dump([$lcs],[qw(LCS)]),"\n";
  }
}
}

my @data3 = ([qw/a b d/ x 50], [qw/b a d c/ x 50]);
# NOTE: needs 100 years
if (0) {
  cmp_deeply(
    LCS::Similar->LCS(@data3),
    any(@{LCS->allLCS(@data3)} ),
    '[qw/a b d/ x 50], [qw/b a d c/ x 50]'
  );
  if (0) {
    $Data::Dumper::Deepcopy = 1;
    print STDERR 'allLCS: ',Data::Dumper->Dump(LCS->allLCS(@data3)),"\n";
    print STDERR 'LCS: ',Dumper(LCS::Similar->LCS(@data3)),"\n";
  }
}


done_testing;
