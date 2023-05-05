[![Actions Status](https://github.com/skaji/PAUSE-Permissions-MetaCPAN/actions/workflows/test.yml/badge.svg)](https://github.com/skaji/PAUSE-Permissions-MetaCPAN/actions)

# NAME

PAUSE::Permissions::MetaCPAN - get module permissions from MetaCPAN API

# SYNOPSIS

    use PAUSE::Permissions::MetaCPAN;

    my $api = PAUSE::Permissions::MetaCPAN->new;

    my $perm = $api->get(author => 'SKAJI');
    # {
    #   co_maintainer => [
    #     {
    #       co_maintainers => ["MIYAGAWA", "SKAJI", "SLANNING", "SYOHEX"],
    #       module_name => "Minilla",
    #       owner => "TOKUHIROM",
    #     },
    #     ...
    #   ],
    #   owner => [
    #     {
    #       co_maintainers => [],
    #       module_name => "Acme::RandomEmoji",
    #       owner => "SKAJI",
    #     },
    #     ...
    #   ],
    # }

    my $perm = $api->get(modules => ['LWP', 'NotFound', 'Plack']);
    # {
    #   LWP => {
    #     co_maintainers => ["ETHER", "GAAS", "MSCHILLI", "MSTROUT", "OALDERS"],
    #     module_name => "LWP",
    #     owner => "LWWWP",
    #   },
    #   NotFound => undef,
    #   Plack => {
    #     co_maintainers => [],
    #     module_name => "Plack",
    #     owner => "MIYAGAWA",
    #   },
    # }

# DESCRIPTION

PAUSE::Permissions::MetaCPAN gets module permissions from MetaCPAN API.

# METHOD

## new

    my $api = PAUSE::Permissions::MetaCPAN->new;

Constructor. It optionally takes the following argument:

- http

    HTTP::Tiny object. Default is

        HTTP::Tiny->new(verify_SSL => 1, agent => 'PAUSE-Permissions-MetaCPAN/VERSION')

- url

    MetaCPAN API url. Default is [https://fastapi.metacpan.org/v1/permission/\_search](https://fastapi.metacpan.org/v1/permission/_search).

## get

    my $perm = $api->get(author => 'AUTHOR');
    my $perm = $api->get(modules => ['Module1', 'Module2', ...]);

Get module permissions from MetaCPAN API. It must be called with either
`author` or `modules` argument.
It returns a hash reference that contains module permissions.

# SEE ALSO

- [PAUSE::Permissions](https://metacpan.org/pod/PAUSE%3A%3APermissions)
- [https://fastapi.metacpan.org/](https://fastapi.metacpan.org/)

# AUTHOR

Shoichi Kaji <skaji@cpan.org>

# COPYRIGHT AND LICENSE

Copyright 2018 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
