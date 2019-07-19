[![Build Status](https://travis-ci.com/jmacdotorg/newsapi-perl.svg?branch=master)](https://travis-ci.com/jmacdotorg/newsapi-perl)
# NAME

Web::NewsAPI - Fetch and search news headlines and sources from News API

# SYNOPSIS

    use Web::NewsAPI;
    use v5.10;

    # To use this module, you need to get a free API key from https://newsapi.org.
    # (The following is a bogus example key that will not actually work. Try it
    # with your own key instead!)
    my $api_key = 'deadbeef1234567890f001f001deadbeef';

    my $newsapi = Web::NewsAPI->new(
       api_key => $api_key,
    );

    say "Here are the top ten headlines from American news sources...";
    my @headlines = $newsapi->top_headlines( country => 'us', pageSize => 10 );
    for my $article ( @headlines ) {
       # Each is a Web::NewsAPI::Article object.
       say $article->title;
    }

    say "Here are the top ten headlines worldwide containing 'chicken'...";
    my @chicken_heds = $newsapi->everything( q => 'chicken', pageSize => 10 );
    for my $article ( @chicken_heds ) {
       # Each is a Web::NewsAPI::Article object.
       say $article->title;
    }

    say "Here are some sources for English-language technology news...";
    my @sources = $newsapi->sources( category => 'technology', language => 'en' );
    for my $source ( @sources ) {
       # Each is a Web::NewsAPI::Source object.
       say $source->name;
    }

# DESCRIPTION

This module provides a simple, object-oriented interface to [the News
API](https://newsapi.org), version 2. It supports that API's three public
endpoints, allowing your code to fetch and search current news headlines
and sources.

# METHODS

## Class Methods

### new

    my $newsapi = Web::NewsAPI->new( api_key => $your_api_key );

Object constructor. Takes a hash as an argument, whose only recognized
key is `api_key`. This must be set to a valid News API key. You can
fetch a key for yourself by registering a free account with News API
[at its website](https://newsapi.org).

Note that the validity of the API key you provide isn't checked until
you try calling one of this module's object methods.

## Object Methods

Each of these methods will attempt to call News API using the API key
you provided during construction. If the call fails, then this module
will throw an exception, sharing the error code and message passed back
from News API.

### top\_headlines

    my @articles = $newsapi->top_headlines( country => 'us' );

Returns a number of [Web::NewsAPI::Article](https://metacpan.org/pod/Web::NewsAPI::Article) objects representing
current top news headlines, narrowed by the supplied argument hash. The
hash must contain _at least one_ of the following keys:

- country

    Limit returned headlines to a single country, expressed as a 2-letter
    ISO 3166-1 code. (See [the News API
    documentation](https://newsapi.org/docs/endpoints/top-headlines) for a
    full list of country codes it supports.)

    News API will return an error if you mix this with `sources`.

- category

    Limit returned headlines to a single category. Possible options include
    `business`, `entertainment`, `general`, `health`, `science`,
    `sports`, and `technology`.

    News API will return an error if you mix this with `sources`.

- sources

    A list of News API source IDs, rendered as a comma-separated string.

    News API will return an error if you mix this with `country` or
    `category`.

- q

    Keywords or a phrase to search for.

You may also provide either of these optional keys:

- pageSize

    The number of results to return per page (request). 20 is the default,
    100 is the maximum.

- page

    Use this to page through the results if the total results found is
    greater than the page size.

### everything

    my @articles = $newsapi->everything( language => 'en' );

Returns a number of [Web::NewsAPI::Article](https://metacpan.org/pod/Web::NewsAPI::Article) objects representing all
news articles matching the query parameters you provide.

### sources

    my @sources = $newsapi->sources( language => 'en' );

Returns a number of [Web::NewsAPI::Source](https://metacpan.org/pod/Web::NewsAPI::Source) objects reprsenting News
API's news sources.

You may provide any of these optional parameters:

- category

    Limit sources to a single category. Possible options include
    `business`, `entertainment`, `general`, `health`, `science`,
    `sports`, and `technology`.

- country

    Limit sources to a single country, expressed as a 2-letter ISO 3166-1
    code. (See [the News API
    documentation](https://newsapi.org/docs/endpoints/sources) for a full
    list of country codes it supports.)

- language

    Limit sources to a single language. Possible options include `ar`,
    `de`, `en`, `es`, `fr`, `he`, `it`, `nl`, `no`, `pt`, `ru`,
    `se`, `ud`, and `zh`.

# AUTHOR

Jason McIntosh (jmac@jmac.org)

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2019 by Jason McIntosh.

This is free software, licensed under:

    The MIT (X11) License
