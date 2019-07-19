requires 'perl', '5.010';

requires 'Moose';
requires 'Moose::Util::TypeConstraints';
requires 'Readonly';
requires 'LWP';
requires 'JSON';
requires 'URI';
requires 'DateTime';
requires 'DateTime::Format::ISO8601';

on 'test' => sub {
    requires 'Test::More', '0.98';
    requires 'Test::LWP::UserAgent';
};
