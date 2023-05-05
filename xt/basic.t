use strict;
use warnings;
use Test::More;
use PAUSE::Permissions::MetaCPAN;

my $api = PAUSE::Permissions::MetaCPAN->new;

subtest author => sub {
    my $perm = $api->get(author => 'SKAJI');
    my ($minilla) = grep { $_->{module_name} eq 'Minilla' } @{$perm->{co_maintainer}};
    ok !!grep { $_ eq 'SKAJI' } @{$minilla->{co_maintainers}};
    is $minilla->{owner}, 'TOKUHIROM';

    my ($cpm) = grep { $_->{module_name} eq 'App::cpm' } @{$perm->{owner}};
    is $cpm->{owner}, 'SKAJI';
};

subtest modules => sub {
    my $perm = $api->get(modules => ['LWP::UserAgent', 'NotExists', 'Moose']);
    is scalar(keys %$perm), 3;
    ok exists $perm->{$_} for 'LWP::UserAgent', 'NotExists', 'Moose';
    ok !$perm->{NotExists};
    is $perm->{'LWP::UserAgent'}{owner}, 'OALDERS';
    is $perm->{Moose}{owner}, 'STEVAN';
};

subtest true_author_test => sub {
    plan skip_all => "be polite";
    open my $fh, "-|", "gzip", "-d", "--stdout", "xt/paws-module.txt.gz" or die;
    my @module = <$fh>;
    close $fh;
    chomp @module;
    my $perm = $api->get(modules => \@module);
    is scalar(keys %$perm), 9026;
    ok !grep { $_->{owner} ne 'JLMARTIN' } values %$perm;
    # diag explain $perm;
};

done_testing;
