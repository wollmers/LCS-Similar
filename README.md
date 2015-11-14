# NAME

LCS::Similar - allow differences in the compared elements of
                 Longest Common Subsequence (LCS) Algorithm

<div>
    <a href="https://travis-ci.org/wollmers/LCS-BV"><img src="https://travis-ci.org/wollmers/LCS-BV.png" alt="LCS-BV"></a>
    <a href='https://coveralls.io/r/wollmers/LCS-BV?branch=master'><img src='https://coveralls.io/repos/wollmers/LCS-BV/badge.png?branch=master' alt='Coverage Status' /></a>
    <a href='http://cpants.cpanauthors.org/dist/LCS-BV'><img src='http://cpants.cpanauthors.org/dist/LCS-BV.png' alt='Kwalitee Score' /></a>
    <a href="http://badge.fury.io/pl/LCS-BV"><img src="https://badge.fury.io/pl/LCS-BV.svg" alt="CPAN version" height="18"></a>
</div>

# SYNOPSIS

    use LCS::BV;

    $alg = LCS::BV->new;
    @lcs = $alg->LCS(\@a,\@b);

# ABSTRACT

LCS::Similar allows differences in the compared elements.

# DESCRIPTION

## CONSTRUCTOR

- new()

    Creates a new object which maintains internal storage areas
    for the LCS computation.  Use one of these per concurrent
    LCS() call.

## METHODS

- LCS(\\@a,\\@b)

    Finds a Longest Common Subsequence, taking two arrayrefs as method
    arguments. It returns an array reference of corresponding
    indices, which are represented by 2-element array refs.

    The third argument is a subroutine comparing two elements and
    returning a number between 0 and 1. Where 0 means unequal and 1 means equal.

    Without a subroutine the module falls back to string comparison.

- max($number1, $number2)

    Returns the maximum of two numbers.

- max3($number1, $number2, $number3)

    Returns the maximum of three numbers.

## EXPORT

None by design.

# SEE ALSO

Algorithm::Diff

# AUTHOR

Helmut Wollmersdorfer <helmut.wollmersdorfer@gmail.com>

<div>
    <a href='http://cpants.cpanauthors.org/author/wollmers'><img src='http://cpants.cpanauthors.org/author/wollmers.png' alt='Kwalitee Score' /></a>
</div>

# COPYRIGHT AND LICENSE

Copyright 2015 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
